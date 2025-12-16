import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/cubits/category/fetch_category_cubit.dart';
import 'package:eClassify/data/model/category_model.dart';
import 'package:eClassify/ui/screens/home/search_screen.dart';
import 'package:eClassify/ui/screens/main_activity.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/app_icon.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';

class AiChatDemoScreen extends StatefulWidget {
  const AiChatDemoScreen({super.key});

  @override
  State<AiChatDemoScreen> createState() => _AiChatDemoScreenState();
}

class _AiChatDemoScreenState extends State<AiChatDemoScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isTyping = false;

  // الأقسام المحملة
  List<CategoryModel> allCategoriesFlat = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    // جلب الأقسام بعد إنشاء الـ Cubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<FetchCategoryCubit>();
      cubit.fetchCategories().then((_) {
        setState(() {
          allCategoriesFlat = cubit.getCategories();
          _flattenCategories(allCategoriesFlat);
        });
      });
    });
  }

  // دالة flatten للأقسام الفرعية
  void _flattenCategories(List<CategoryModel> categories) {
    List<CategoryModel> flatList = [];
    void flatten(CategoryModel cat) {
      flatList.add(cat);
      if (cat.children != null && cat.children!.isNotEmpty) {
        for (var child in cat.children!) {
          flatten(child);
        }
      }
    }

    for (var category in categories) {
      flatten(category);
    }

    allCategoriesFlat = flatList;
  }

  /// ---------------- AI TEXT KNOWLEDGE ----------------
  final List<Map<String, dynamic>> _faqData = [
    {
      'keywords': ['مرحبا', 'اهلا', 'السلام', 'مرحبا بك'],
      'answer':
      'مرحباً بك 👋\nأنا مساعد بريق الذكي، جاهز لمساعدتك في كل ما يتعلق بالتعدين والمعدات في السودان.'
    },
    {
      'keywords': ['مجاني', 'متاح', 'شامل'],
      'answer':
      'تطبيق بريق مجاني وشامل، يوفر لك كل المعلومات والخدمات المتعلقة بالتعدين والمعدات في السودان.'
    },
    // ... أضف باقي الأسئلة والأجوبة هنا كما في كودك السابق
  ];

  /// ---------------- NAVIGATION COMMANDS ----------------
  late final List<Map<String, dynamic>> _navigationCommands = [
    {
      'keywords': ['حسابي', 'الملف الشخصي', 'بروفايل'],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة الملف الشخصي 👤',
      'action': () {
        Navigator.pushNamed(context, Routes.profileScreen);
      },
    },
    {
      'keywords': ['اعلاناتي', 'إعلانات', 'مشاريعي'],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة الإعلانات 📢',
      'action': () {
        Navigator.pushNamed(context, Routes.myAdvertisment);
      },
    },
    {
      'keywords': ['فتح الاجراءات', 'معلومات عن', 'وزارات', 'دليل', 'ارشادات'],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة الاجراءات ...',
      'action': () {
        Navigator.pushNamed(context, Routes.homeGuide);
      },
    },
    {
      'keywords': ['بحث', 'ابحث', 'find'],
      'response': 'جاري فتح شاشة البحث 🔍',
      'action': () {
        if (SearchScreenState.searchController.hasListeners) {
          SearchScreenState.searchController.text = 'حفار';
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(autoFocus: true),
          ),
        );
      },
    },
  ];

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: 'مرحباً 👋\nأنا مساعد بريق الذكي. كيف يمكنني مساعدتك؟',
      isUser: false,
    ),
  ];

  /// ---------------- MESSAGE HANDLING ----------------
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    if (_speech.isListening) _speech.stop();

    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    Timer(const Duration(seconds: 2), () {
      final aiMessage = _buildAiResponse(text);

      setState(() {
        _messages.add(aiMessage);
        _isTyping = false;
      });

      _scrollToBottom();

      if (aiMessage.action != null) {
        FocusScope.of(context).unfocus();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          aiMessage.action!();
        });
      }
    });
  }

  _ChatMessage _buildAiResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    // --------- قسم ---------
    if (message.contains('قسم ')) {
      final query = message.split('قسم ')[1].trim().toLowerCase();

      // البحث داخل جميع الأقسام
      CategoryModel? foundCategory;
      for (var cat in allCategoriesFlat) {
        if (cat.name != null && cat.name!.toLowerCase() == query) {
          foundCategory = cat;
          break;
        }
      }

      if (foundCategory != null) {
        return _ChatMessage(
          text: 'جاري فتح قسم ${foundCategory.name} ✅',
          isUser: false,
          action: () {
            if (foundCategory!.children == null || foundCategory!.children!.isEmpty) {
              Navigator.pushNamed(context, Routes.itemsList, arguments: {
                'catID': foundCategory.id.toString(),
                'catName': foundCategory.name,
                'categoryIds': [foundCategory.id.toString()],
              });
            } else {
              Navigator.pushNamed(context, Routes.subCategoryScreen, arguments: {
                'categoryList': foundCategory.children,
                'catName': foundCategory.name,
                'catId': foundCategory.id,
                'categoryIds': [foundCategory.id.toString()],
              });
            }
          },
        );
      }
    }

    // --------- NAVIGATION COMMANDS ---------
    for (final cmd in _navigationCommands) {
      for (final keyword in cmd['keywords']) {
        if (message.contains(keyword)) {
          return _ChatMessage(
            text: cmd['response'],
            isUser: false,
            action: cmd['action'],
          );
        }
      }
    }

    // --------- TEXT ANSWERS ---------
    for (final item in _faqData) {
      for (final keyword in item['keywords']) {
        if (message.contains(keyword)) {
          return _ChatMessage(
            text: item['answer'],
            isUser: false,
          );
        }
      }
    }

    return _ChatMessage(
      text: 'انا هنا لمساعدتك، فقط أخبرني بما تريد 👍',
      isUser: false,
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  /// ---------------- VOICE HANDLING ----------------
  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'done' || val == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (val) => setState(() => _isListening = false),
    );

    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) {
          setState(() {
            _controller.text = val.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _onVoicePressed() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  /// ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FetchCategoryCubit(),
      child: WillPopScope(
        onWillPop: () async {
          FocusScope.of(context).unfocus();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainActivity(from: 'flug')),
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: context.color.mainBrown,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: context.color.mainGold,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: context.color.mainBrown,
                  child: UiUtils.getSvg(AppIcons.plusIcon, height: 38),
                ),
                const SizedBox(width: 12),
                const Text(
                  'مساعد بريق',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainActivity(from: 'flug')),
                  );
                },
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (_isTyping && index == _messages.length) {
                      return const _TypingIndicator();
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: _ChatBubble(
                        key: ValueKey(_messages[index].text),
                        message: _messages[index],
                      ),
                    );
                  },
                ),
              ),
              _InputBar(
                controller: _controller,
                onSend: _sendMessage,
                onVoice: _onVoicePressed,
                isListening: _isListening,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===================== MODELS =====================
class _ChatMessage {
  final String text;
  final bool isUser;
  final VoidCallback? action;

  _ChatMessage({
    required this.text,
    required this.isUser,
    this.action,
  });
}

/// ===================== WIDGETS =====================
class _ChatBubble extends StatelessWidget {
  final _ChatMessage message;

  const _ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: message.action,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: message.isUser
                ? const Color(0xFF714130)
                : const Color(0xFFEFD271),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: message.isUser ? const Color(0xFFEFD271) : Colors.black87,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFEFD271),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('مساعد بريق يفكر'),
            SizedBox(width: 8),
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final VoidCallback onVoice;
  final bool isListening;

  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.onVoice,
    this.isListening = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      color: context.color.mainGold,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
                isListening ? Icons.mic_off : Icons.mic,
                color: context.color.mainBrown
            ),
            onPressed: onVoice,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: onSend,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            backgroundColor: context.color.mainBrown,
            onPressed: () => onSend(controller.text),
            child: const Icon(Icons.send, size: 18),
          ),
        ],
      ),
    );
  }
}
