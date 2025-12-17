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

  final List<String> _categoryCommandKeywords = [
    'افتح',
    'أريد',
    'انتقل',
    'قسم',
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isTyping = false;
  List<String> _suggestions = [];
  bool _showSuggestions = false;


  // الأقسام المحملة
  List<CategoryModel> allCategoriesFlat = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _controller.addListener(_onTextChanged);
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

  void _onTextChanged() {
    final input = _controller.text.trim();

    if (input.isEmpty) {
      setState(() {
        _suggestions.clear();
        _showSuggestions = false;
      });
      return;
    }

    final List<String> results = [];

    // من faqData
    for (final item in _faqData) {
      for (final keyword in item['keywords']) {
        if (keyword.startsWith(input)) {
          results.add(keyword);
        }
      }
    }

    // من أوامر التنقل
    for (final cmd in _navigationCommands) {
      for (final keyword in cmd['keywords']) {
        if (keyword.startsWith(input)) {
          results.add(keyword);
        }
      }
    }

    // من أسماء الأقسام
    for (final cat in allCategoriesFlat) {
      final name = cat.name ?? '';
      if (name.startsWith(input)) {
        results.add(name);
      }
    }

    setState(() {
      _suggestions = results.toSet().take(6).toList();
      _showSuggestions = _suggestions.isNotEmpty;
    });
  }


  /// ---------------- AI TEXT KNOWLEDGE ----------------
  final List<Map<String, dynamic>> _faqData = [
    // الترحيب والأساسيات
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
    // عن التطبيق والبريق
    {


      'keywords': ['بريق', 'التطبيق', 'كيف يعمل التطبيق', 'مساعدة ', 'تساعدني '],
      'answer':
          'بريق منصة ذكية تربط بين شركات التعدين، المعدات، والموردين، لتسهيل عمليات البحث والتواصل وإدارة المشاريع.'
    },
    // التعدين في السودان

    {
      'keywords': ['مشاريع التعدين', 'مشاريع'],
      'answer':
          'يمكنك متابعة أحدث مشاريع التعدين في السودان ومعرفة المعدات المستخدمة وحجم الإنتاج المتوقع عبر التطبيق.'
    },
    {
      'keywords': ['تعدين', 'معادن', 'التعدين'],
      'answer':
      'التعدين في السودان يشمل الذهب والمعادن الأخرى، وبريق يساعدك في كل التفاصيل.'
    },
    {
      'keywords': ['معدات', 'معدات التعدين', 'آليات'],
      'answer':
          'نوفر معلومات عن أنواع المعدات والآليات المستخدمة في التعدين، مثل الحفارات، القلابات، والمولدات، بالإضافة إلى الموردين المحليين.'
    },
    // أسئلة عملية للمستخدم
    {
      'keywords': ['شراء معدات', 'تأجير معدات', 'بيع معدات', 'بيع ', 'شراء '],
      'answer':
          'يمكنك البحث عن معدات للبيع أو التأجير في السودان، ومقارنة الأسعار والمواصفات عبر بريق.'
    },
    {
      'keywords': ['تراخيص', 'رخصة', 'إجراءات'],
      'answer':
          'للحصول على تراخيص التعدين في السودان، يجب اتباع القوانين المحلية، ويمكنك معرفة التفاصيل والإجراءات من خلال التطبيق.'
    },
    {
      'keywords': ['اتصال', 'موردين', 'شركات'],
      'answer':
          'بريق يوفر معلومات الاتصال بالموردين وشركات التعدين في السودان لتسهيل التعاون والمشاريع.'
    },
    // نصائح وتحسين تجربة المستخدم
    {
      'keywords': ['نصيحة', 'إرشادات', 'كيفية البدء'],
      'answer':
          'لبدء مشروع تعدين، تأكد من معرفة القوانين المحلية، المعدات المطلوبة، والموردين المناسبين. بريق يساعدك على كل هذه الخطوات.'
    },
    {
      'keywords': ['اضافة', 'اعلان', 'انشاء'],
      'answer':
          'ببساطة قم بتحديد القسم الذي تريده ومن ثم انتقل إلى زرار إضافة إعلانك لتقوم بإضافة إعلان بسهولة في منصتنا'
    },
    {
      'keywords': ['ايكوبيشن', 'كوبيشن', 'ايكيوبيشن', 'اكوبيشن', 'اكيوبيشن'],
      'answer':
          'شركة إكوبيشن للاستثمار المحدودة، تأسست في عام 2021م كشركة سودانية واعدة في مجال خدمات التعدين، حيث تقدم مجموعة شاملة ومتكاملة من الخدمات في هذا القطاع،'
    },
    //
    // {
    //   'keywords': ['وزير', 'وزير المعادن', 'نور الدائم', 'وزارة'],
    //   'answer':
    //   ' وزير المعادن الحالي في السودان هو الأستاذ نور الدائم طه، '
    //       'الذي يركز في عمله على تطوير قطاع التعدين وتعزيز الشراكات الدولية، '
    //       'خاصة مع الصين، وتنفيذ مشاريع تنموية في مناطق التعدين من خلال المسؤولية المجتمعية.'
    // },

    {
      'keywords': ['دورك', 'تساعدني', 'كيف يمكن تساعدني', 'بماذا تساعدني','ماذا تقدم' ,'كيف تعمل'],
      'answer':
      'انا هنا لمساعدتك في الاجابة عن اسئلتك حول التعدين في السودان او حول منصة بريق او شركة ايكوبيشن او توجيهك للمكان المناسب داخل التطبيق عن طريق النص او الاوامر الصوتية'
    },


    {
      "keywords":  ['من هو وزير المعادن الحالي في السودان؟', 'وزير المعادن','وزير'],
      "answer": "معالي المهندس نور الدائم محمد أحمد طه، الذي تولى منصب وزير المعادن في يوليو 2025 ضمن حكومة الأمل. يتميز معاليه بخلفية مهنية قوية واهتمام واضح بالتحول الرقمي والابتكار التقني في قطاع التعدين."
    },
    {
      "keywords": ['ما هي رؤية وزير المعادن للقطاع؟', ' رؤية','القطاع','للقطاع','رؤية الوزير'],
      "answer": "يتبنى معالي الوزير رؤية حديثة تقوم على ثلاثة محاور: أولاً، التحول الرقمي الكامل للقطاع مع دمج الذكاء الاصطناعي في العمليات. "
          "ثانياً، الشفافية والمهنية في الإدارة بعيداً عن الاستقطاب السياسي."
          " ثالثاً، تطوير الشراكات الاستراتيجية وجذب الاستثمارات لتعظيم مساهمة القطاع في الاقتصاد الوطني."
    },
    {
      "keywords": ['هل يهتم الوزير بالتحول الرقمي؟', ' التحول الرقمي','الرقمي'],
      "answer": "نعم، يولي معالي الوزير نور الدائم طه اهتماماً استثنائياً بالتحول الرقمي. يؤمن معاليه بأن دمج التقنيات الحديثة والذكاء الاصطناعي في قطاع التعدين ليس خياراً بل ضرورة استراتيجية لتحسين الإنتاجية، تعزيز الشفافية، ومواكبة المعايير الدولية."
    },
    {
      "keywords": ['ما موقف الوزير من الذكاء الاصطناعي في التعدين؟', ' الذكاء الاصطناعي في التعدين','موقف'],
      "answer": "يتبنى معالي الوزير موقفاً متقدماً تجاه توظيف الذكاء الاصطناعي في قطاع التعدين. يؤمن بأن AI يمكن أن يحدث ثورة في عمليات الاستكشاف، الإنتاج، إدارة سلاسل الإمداد، والصيانة التنبؤية. هذا التوجه يجعل الوزارة منفتحة على الشراكات مع الشركات التقنية المحلية التي تقدم حلولاً ذكية."
    },
    {
      "keywords": ['ما هي أولويات الوزير الحالية؟', ' أولويات','أولويات الوزير'],
      "answer": "تتركز أولويات معالي الوزير على: تسريع التحول الرقمي في كافة عمليات القطاع، تعزيز الشفافية من خلال الأنظمة الإلكترونية، تطوير البنية التحتية للمعلومات، جذب الاستثمارات النوعية، ودعم المبادرات المحلية المبتكرة في مجال تقنيات التعدين."
    },
    {
      "keywords": ['كيف يدعم الوزير الشركات المحلية؟', ' يدعم','الشركات المحلية','المحلية'],
      "answer": "يؤمن معالي الوزير بأهمية الحلول المحلية والشراكات مع الشركات السودانية. يشجع معاليه المبادرات التقنية الوطنية ويسعى لتوفير بيئة داعمة للابتكار، خاصة في مجالات التحول الرقمي والذكاء الاصطناعي التي تخدم القطاع."
    },
    {
      "keywords":  ['ما رأي الوزير في منصة بريق؟', ' رأي', ' رؤية', ' رؤية وزير'],
      "answer": "منصة بريق تمثل نموذجاً مميزاً للابتكار التقني السوداني في قطاع التعدين. كونها المنصة الوحيدة الحاصلة على ترخيص حكومي كامل، فهي تتماشى تماماً مع رؤية معالي الوزير للتحول الرقمي. قدرة بريق على دمج الذكاء الاصطناعي لتحسين كفاءة العمليات وتعزيز الشفافية تجعلها شريكاً استراتيجياً محتملاً للوزارة."
    },
    {
      "keywords": ['هل يدعم الوزير المنصات الرقمية للتعدين؟', ' الرقمية','المنصات','يدعم'],
      "answer": "بالتأكيد. يرى معالي الوزير أن المنصات الرقمية المتخصصة هي المستقبل لقطاع التعدين. أثبتت النافذة الموحدة لصادر الذهب نجاح هذا النموذج، والوزارة منفتحة على توسيع نطاق الرقمنة ليشمل كافة جوانب القطاع من خلال منصات متخصصة وموثوقة."
    },
    {
      "keywords": ['ما التحديات التي يواجهها الوزير؟', ' التحديات','تحدي ','يواجهها'],
      "answer": "يدير معالي الوزير القطاع في ظروف استثنائية: الحرب والتحديات الأمنية، البنية التحتية المتضررة، الحاجة لتحديث الأنظمة القديمة، ومحاربة التهريب. لكن معاليه يرى في التحول الرقمي والابتكار التقني حلولاً فعالة لكثير من هذه التحديات."
    },
    {
      "keywords": ['كيف يمكن للقطاع الخاص التعاون مع الوزارة؟', ' التعاون'],
      "answer": "الوزارة ترحب بالشراكات الاستراتيجية مع القطاع الخاص، خاصة في مجالات: تطوير الحلول التقنية، التحول الرقمي، نقل المعرفة، والاستثمار في البنية التحتية. الشركات المحلية التي تقدم حلولاً مبتكرة وموثوقة تحظى باهتمام خاص."
    },
    {
      "keywords": ['ما موقف الوزير من الشفافية؟', ' الشفافية','موقف '],
      "answer": "الشفافية أحد المبادئ الأساسية لمعالي الوزير. يؤمن بأن التقنيات الرقمية والذكاء الاصطناعي هي أدوات قوية لتحقيق الشفافية الكاملة في العمليات، من الاستكشاف حتى التصدير، مما يحارب الفساد ويعزز ثقة المستثمرين."
    },
    {
      "keywords":  ['متى تولى نور الدائم طه منصب وزير المعادن؟', ' منصب','تولى '],
      "answer": "تولى معالي المهندس نور الدائم محمد أحمد طه منصب وزير المعادن في يوليو 2025، خلفاً للوزير السابق محمد بشير أبو نمو، ضمن التشكيلة الحكومية المعروفة بـ 'حكومة الأمل'."
    },
    {
      "keywords": ['ما الخلفية المهنية للوزير؟', ' الخلفية','المهنية ','خلفية الوزير'],
      "answer": "معالي الوزير مهندس بخلفية مهنية قوية ويتمتع بخبرات فنية في مجال التعدين. هذه الخلفية الهندسية تنعكس في نهجه العملي والتقني في إدارة القطاع، وانفتاحه على الحلول التكنولوجية المتقدمة."
    },
    {
      "keywords": ['ما المبادرات التي أطلقها الوزير؟', ' المبادرات','أطلقها '],
      "answer": "منذ توليه، قام معالي الوزير بعدة مبادرات: تفقد النافذة الموحدة لصادر الذهب وأشاد بأدائها، عقد لقاءات مع سفراء دول عربية وأفريقية لتعزيز التعاون، ترأس اجتماعات إقليمية لوزراء المعادن، وركز على تطوير الأنظمة الرقمية في القطاع."
    },
    {
      "keywords": ['كيف ينظر الوزير لمستقبل القطاع؟', ' ينظر','لمستقبل ','مستقبل','القطاع'],
      "answer": "ينظر معالي الوزير بتفاؤل كبير لمستقبل قطاع التعدين. يؤمن بأن السودان، بموارده الهائلة وموقعه الاستراتيجي في الحزام الذهبي الأفريقي، يمكن أن يصبح نموذجاً إقليمياً في التعدين الذكي المستدام، شرط الاستثمار في التقنيات الحديثة والشراكات الاستراتيجية."
    }

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
      'keywords': ['عمله', 'دولار', 'اسعار العملة', 'العملات'],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة اسعار العملة 📢',
      'action': () {
        Navigator.pushNamed(context, Routes.mony_exchange);
      },
    },
    {
      'keywords': ['تصفح', 'اخبار', 'الاخبار '],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة  الاخبار 📢',
      'action': () {
        Navigator.pushNamed(context, Routes.blogsScreenRoute);
      },
    },
    {
      'keywords': ['عمل', 'وظيفة', 'التوظيف ', 'وظيفه', 'تقديم'],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة  الوظائف 📢',
      'action': () {
        Navigator.pushNamed(context, Routes.jobs);
      },
    },
    {
      'keywords': ['وكيل', 'وكلاء', 'متاجر '],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة  المتاجر 📢',
      'action': () {
        Navigator.pushNamed(context, Routes.provideStore);
      },
    },
    {
      'keywords': ['جرام', 'صفحه البورصة', 'بورصه', 'ذهب'],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة  البورصة 📢',
      'action': () {
        Navigator.pushNamed(context, Routes.mining_exchange);
      },
    },
    {
      'keywords': ['تعلم', 'دورات', 'تدريب'],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة  الدورات  📢',
      'action': () {
        Navigator.pushNamed(context, Routes.visualMaterialsPage);
      },
    },
    {
      'keywords': [
        'فتح الاجراءات',
        'معلومات عن',
        'وزارات',
        'دليل',
        'ارشادات',
        'بنك'
      ],
      'response': 'تم تنفيذ طلبك ✅\nجاري فتح صفحة الاجراءات ...',
      'action': () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => MainActivity(from: 'external'),
          ),
          (route) => false,
        );

// بعد فتح MainActivity افتح التاب المطلوب
        Future.delayed(const Duration(milliseconds: 100), () {
          MainActivity.globalKey.currentState?.onItemTapped(2); // تب الإجراءات
        });
      },
    },
    {
      'keywords': ['بحث', 'ابحث', 'find'],
      'response': 'جاري فتح شاشة البحث 🔍',
      'action': () {
        // إعادة تعيين النص في Controller إن لزم
        if (SearchScreenState.searchController.hasListeners) {
          SearchScreenState.searchController.text = 'حفار';
        }

        // الانتقال إلى شاشة البحث
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SearchScreen(
                    autoFocus: true,
                  )),
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

// --------- CATEGORY INTENT DETECTION ---------
    String? extractedCategoryName;

// محاولة استخراج اسم القسم بناءً على كلمات الأمر
    for (final keyword in _categoryCommandKeywords) {
      if (message.contains(keyword)) {
        extractedCategoryName =
            message.split(keyword).last.trim().toLowerCase();
        break;
      }
    }

    if (extractedCategoryName != null && extractedCategoryName.isNotEmpty) {
      CategoryModel? foundCategory;

      for (final cat in allCategoriesFlat) {
        final catName = cat.name?.toLowerCase() ?? '';

        // تطابق كامل أو جزئي
        if (catName == extractedCategoryName ||
            catName.contains(extractedCategoryName) ||
            extractedCategoryName.contains(catName)) {
          foundCategory = cat;
          break;
        }
      }

      if (foundCategory != null) {
        return _ChatMessage(
          text: 'جاري فتح قسم ${foundCategory.name} ✅',
          isUser: false,
          action: () {
            if (foundCategory!.children == null ||
                foundCategory!.children!.isEmpty) {
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
    // for (final item in _faqData) {
    //   for (final keyword in item['keywords']) {
    //     if (message.contains(keyword)) {
    //       return _ChatMessage(
    //         text: item['answer'],
    //         isUser: false,
    //       );
    //     }
    //   }
    // }


    final List<Map<String, dynamic>> matches = [];
    for (final item in _faqData) {
      final keywords = List<String>.from(item['keywords'] ?? []);
      for (final keyword in keywords) {
        final keyLower = keyword.toLowerCase();
        if (message.contains(keyLower)) {
          matches.add({
            'keyword': keyLower,
            'answer': item['answer'],
            'action': item['action'], // لو في action
          });
        }
      }
    }

    // 2️⃣ إذا كان هناك تطابقات
    if (matches.isNotEmpty) {
      // اختر الكلمة المفتاحية الأطول أولًا لأنها أدق
      matches.sort((a, b) => b['keyword'].length.compareTo(a['keyword'].length));

      return _ChatMessage(
        text: matches.first['answer'],
        isUser: false,
      );
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
                    MaterialPageRoute(
                        builder: (context) => MainActivity(from: 'flug')),
                  );
                },
              )
            ],
          ),
          body: SafeArea(
            child: Column(
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if (_showSuggestions)
                    //   Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 12),
                    //     padding: const EdgeInsets.symmetric(vertical: 6),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(12),
                    //       boxShadow: const [
                    //         BoxShadow(color: Colors.black12, blurRadius: 6),
                    //       ],
                    //     ),
                    //     child: ListView.builder(
                    //       shrinkWrap: true,
                    //       itemCount: _suggestions.length,
                    //       itemBuilder: (context, index) {
                    //         final suggestion = _suggestions[index];
                    //         return ListTile(
                    //           dense: true,
                    //           title: Text(suggestion),
                    //           onTap: () {
                    //             _controller.text = suggestion;
                    //             _controller.selection = TextSelection.fromPosition(
                    //               TextPosition(offset: suggestion.length),
                    //             );
                    //             setState(() {
                    //               _showSuggestions = false;
                    //             });
                    //           },
                    //         );
                    //       },
                    //     ),
                    //   ),

                    _InputBar(
                      controller: _controller,
                      onSend: _sendMessage,
                      onVoice: _onVoicePressed,
                      isListening: _isListening,
                    ),
                  ],
                )
              ],
            ),
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
            icon: Icon(isListening ? Icons.mic_off : Icons.mic,
                color: context.color.mainBrown),
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
