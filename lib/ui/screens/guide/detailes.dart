import 'dart:async';
import 'package:eClassify/data/model/equipation/guide_modale.dart';
import 'package:eClassify/ui/screens/widgets/equipation_widgets/popup_menue/menue_item_rular.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/translator.dart';

/// TTSController wraps flutter_tts usage and voice listing.
class TTSController {
  final FlutterTts _tts = FlutterTts();
  List<dynamic> voices = [];
  String? selectedVoice;
  double speechRate = 0.45;
  double pitch = 1.0;
  double volume = 1.0;

  TTSController();

  Future init() async {
    try {
      await _tts.setLanguage("ar-SA");
    } catch (e) {
      // ignore if language not available
    }
    await _tts.setSpeechRate(speechRate);
    await _tts.setPitch(pitch);
    await _tts.setVolume(volume);

    try {
      final v = await _tts.getVoices;
      if (v != null) voices = v;
      // Filter Arabic locales if found
      final arVoices = voices.where((vv) {
        try {
          final locale = vv["locale"] ?? vv["language"] ?? "";
          return locale.toString().startsWith("ar");
        } catch (e) {
          return false;
        }
      }).toList();
      if (arVoices.isNotEmpty) {
        voices = arVoices;
      }
      if (voices.isNotEmpty) {
        // pick first voice
        selectedVoice = voices.first["name"] ??
            voices.first["voice"] ??
            voices.first.toString();
        await setVoice(selectedVoice!);
      }
    } catch (e) {
      // getVoices may throw on some platforms; ignore gracefully
    }
  }

  Future setVoice(String name) async {
    selectedVoice = name;
    try {
      await _tts.setVoice({"name": name});
    } catch (e) {
      // fallback: ignore
    }
  }

  Future speak(String text) async {
    // stop previous audio to avoid overlap
    try {
      await _tts.stop();
    } catch (e) {}
    await _tts.speak(text);
  }

  Future stop() async {
    try {
      await _tts.stop();
    } catch (e) {}
  }

  Future pause() async {
    try {
      await _tts.pause();
    } catch (e) {
      // pause not always supported
    }
  }
}

/// The main reader page with all settings.
class Detailes extends StatefulWidget {
  final String title;

  const Detailes({
    Key? key,
    required this.title,
  }) : super(key: key);

  static Route route(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Detailes(
        title: args['title'] as String,
      ),
    );
  }

  @override
  State<Detailes> createState() => _DetailesState();
}

class _DetailesState extends State<Detailes> {
  List<GuideModale> guideModale = [
    GuideModale(title: "تسجيل الشركات ", content: '''
1-	طلب تسجيل الشركة متضمننا ثلاثة أسماء مقترحة بعد موافقة الشركاء
2-	سداد رسوم التسجيل وإرفاق إيصال  السداد
3-	إرفاق عقد التأسيس ولائحة الشركة 
4-	إرفاق هويات المساهمين 
5-	في حالة وجود رأس مال أجنبي ملء إستمارة الاجانب
6-	تحديد نشاط الشركة
    '''),
    GuideModale(title: "تسجيل اسماء الاعمال", content: '''
1-	طلب تسجيل إسم العمل وعدد 2 إسم بديل 
2-	الرخصة التجارية لإسم العمل 
3-	سداد الرسوم
4-	ملء إستمارة تسجيل إسم العمل
5-	توثيق أسم العمل
    '''),
    GuideModale(title: "طلب ترخيص جديد", content: '''
1-	دراسة الجدوى للمشروع 
2-	صورة من عقد التأسيس
3-	كتابة الطلب 
4-	سداد الرسوم
5-	موافقة الوزارة المختصة 
6-	التوكيل القانوني في حالة عدم وجود صاحب المشروع 
    '''),
    GuideModale(title: "طلب الترخيص", content: '''
1-	طلب الترخيص
2-	إرفاق شهادة التسجيل صادرة من المسجل التجاري 
3-	دفع الرسوم بعد الحصول على الموافقة 
الشركة السودانية للموارد المعدنية 
    '''),
    GuideModale(title: "رخصة التعدين", content: '''
1-دراسة جدوي فنية وإقتصادية ومقبولة بنكياً 
2-خطة تطوير وفقاً للمعايير الدولية والمبادئ الهندسية
3-تكوين شركةالإنتاج تكوين مجلس الإدارة لشركة الأنتاج
4-مخاطبة الوزير لإستخراج رخصة التعدين
    '''),
    GuideModale(
      title: "تراخيص المحليات",
      content: '''
1- رخصة بحث صادرة من وزارة المعادن
2- شهادة تسجيل المسجل التجاري
3- خطة البحث
4- رأس المال
5- دراسة الجدوى
''',
    ),
    GuideModale(title: "الحساب الشخصي", content: '''
•	اثبات شخصية.
•	اثبات دخل/اصحاب الاعمال الحرة/اصحاب المهن/ اخري.
•	مبلغ للايداع.
•	شخصان مزكيان للحساب.
    '''),
    GuideModale(title: "حسابات الشركات", content: '''
•	نسخة من شهادة تسجيل الشركة.
•	 عقد ولائحة تاسيس الشركة .
•	 شهادات الايداعات من المسجل التجاري (اورنيك28) .
•	 خطاب من الشركة موقع من رئيس مجلس الادارة والامين العام باختيار البنك لفتح الحساب ويوضح فيه اسماء المخولين بادارة الحساب وسلطات توقيعهم (أ) و (ب).
•	 اثبات شخصية المخولين بادارة الحساب .
    '''),
    GuideModale(title: "إجراءات الاستيراد (الجمارك السودانية )", content: '''
         –      شهادة مصرفية من أي بنك تجاري (I.M) .
         –      شهادة من الهيئة العامة للمواصفات والمقاييس .
         –      الفواتير .
         –      بوالص الشحن .
         –      إذن التسليم من الشركة الناقلة .
         –      شهادة المنشأ حسب مقتضي الحال .
         –     تصديق من الجهة المعينة والمختصة إن كانت السلعة من السلع المقيدة .
         –     كشف التعبيئة .
         –     بوليصة تامين .
    '''),
    GuideModale(title: "ترخيص الافراد", content: '''
1-	شهادة وارد المركبة أو شهادة البحث .
2-	إثبات شخصية المالك الجديد للمركبة .
3-	خطاب رهن المركبة إذا كان على المركبة رهن لجهة أخرى .
4-	عقد البيع إذا كان اسم المالك غير مطابق لشهادة الوارد.
5-	معاينة المركبة من قبل الإدارة العامة للمرور.
6-	إجراءات الدفاع المدني .
7-	وثيقة تأمين المركبة .
8-	دفع الرسوم المالية .
9-	إصدار شهادة البحث .
    '''),
    GuideModale(title: "ترخيص الشركات", content: '''
1-	شهادة وارد المركبة أو شهادة البحث .
2-	شهادة تسجيل الشركة مع  خطاب تفويض شخص للقيام بالترخيص .
3-	خطاب رهن المركبة إذا كان على المركبة رهن لجهة أخرى .
4-	عقد البيع إذا كان اسم المالك غير مطابق لشهادة الوارد.
5-	معاينة المركبة من قبل الإدارة العامة للمرور.
6-	إجراءات الدفاع المدني .
7-	وثيقة تأمين المركبة .
8-	دفع الرسوم المالية .
9-	إصدار شهادة البحث .
    '''),
    GuideModale(title: "إجراءات التأمين", content: '''
1-	طلب التأمين .
2-	الأوراق الثبوتية للعين موضع التأمين والبيانات الخاصة بها .
3-	معاينة العين موضع التأمين .
4-	دفع الرسوم وإصدار الوثائق التأمينية .
    ''')
  ];

  final TTSController tts = TTSController();
  final ScrollController scroll = ScrollController();
  final GoogleTranslator translator = GoogleTranslator();

  // UI and settings
  bool isDark = false;
  String selectedFont = "Cairo"; // must match configured fonts in pubspec.yaml
  double fontSize = 16.0;
  Color fontColor = Colors.black;
  double brightness = 1.0;
  double scrollSpeed = 1.0;

  // reading state
  bool isSpeaking = false;
  int highlightedIndex = -1;
  late List<String> words;
  Timer? readTimer;
  int currentWordIndex = 0;

  // text management
  late String displayedText; // current text shown (may be translated)
  late String originalText;
  late String selectedFlag;

  // translation state
  bool translating = false;

  @override
  void initState() {
    super.initState();
    // ابحث عن المحتوى حسب العنوان الممرر
    final matchedGuide = guideModale.firstWhere(
      (e) => e.title.toLowerCase().contains(widget.title.toLowerCase()),
      orElse: () => guideModale.first,
    );

    originalText = matchedGuide.content; // نص المحتوى الأصلي
    displayedText = matchedGuide.content; // نص المعروض
    selectedFlag = matchedGuide.title; // العنوان المحدد
    words = _splitWords(displayedText);
    words = _splitWords(displayedText);
    tts.init();
    _loadInitialBrightness();
  }

  List<String> _splitWords(String text) {
    return [text];
  }

  Future _loadInitialBrightness() async {
    try {
      double b = await ScreenBrightness().current;
      setState(() {
        brightness = b.clamp(0.1, 1.0);
      });
    } catch (e) {
      // ignore if not available
    }
  }

  /// Start word-by-word reading with highlight and auto-scroll.
  Future startReading() async {
    if (isSpeaking) return;
    setState(() {
      isSpeaking = true;
      highlightedIndex = -1;
      // keep currentWordIndex as-is when resuming; if starting new ensure 0
      if (currentWordIndex >= words.length) currentWordIndex = 0;
      if (currentWordIndex < 0) currentWordIndex = 0;
    });

    for (; currentWordIndex < words.length; currentWordIndex++) {
      if (!isSpeaking) break;

      setState(() {
        highlightedIndex = currentWordIndex;
      });

      // Auto-scroll: approximate position by fraction of words
      final fraction =
          currentWordIndex / (words.length == 0 ? 1 : words.length);
      final hasDims = scroll.hasClients && scroll.position.hasContentDimensions;
      final max = hasDims ? scroll.position.maxScrollExtent : 0.0;
      final target = max * fraction;
      if (hasDims) {
        try {
          await scroll.animateTo(target,
              duration: Duration(milliseconds: (800 ~/ scrollSpeed)),
              curve: Curves.easeOut);
        } catch (e) {
          // ignore animation errors (controller not ready)
        }
      }

      final word = words[currentWordIndex];
      try {
        await tts.speak(word);
      } catch (e) {
        // fallback: try speaking the word again
        try {
          await tts.speak(word);
        } catch (e) {}
      }

      final waitMs = (500 ~/ scrollSpeed).clamp(70, 2000);
      await Future.delayed(Duration(milliseconds: waitMs));
    }

    // finished
    setState(() {
      isSpeaking = false;
      highlightedIndex = -1;
      // keep currentWordIndex at end for potential resume
    });
  }

  void stopReading() {
    tts.stop();
    readTimer?.cancel();
    setState(() {
      isSpeaking = false;
      highlightedIndex = -1;
      currentWordIndex = 0;
    });
  }

  void pauseReading() {
    tts.pause();
    setState(() {
      isSpeaking = false;
    });
  }

  void resumeReading() {
    // resume is implemented by restarting startReading which uses currentWordIndex
    if (!isSpeaking && currentWordIndex < words.length) {
      setState(() {
        isSpeaking = true;
      });
      startReading();
    }
  }

  /// Translate the whole displayed text to the chosen language code (e.g., "en").
  Future<void> translateContent(String toLang) async {
    setState(() => translating = true);
    try {
      final res = await translator.translate(originalText, to: toLang);
      final newText = res.text;
      setState(() {
        displayedText = newText;
        words = _splitWords(displayedText);
        // reset reading state because content changed
        highlightedIndex = -1;
        currentWordIndex = 0;
        isSpeaking = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تمت الترجمة ")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل في الترجمة. حاول مرة أخرى.")),
      );
    } finally {
      setState(() => translating = false);
    }
  }

  void openTranslateMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final langs = {
          "العربية": "ar",
          "الإنجليزية": "en",
          "الفرنسية": "fr",
          "الألمانية": "de",
          "الإسبانية": "es",
          "التركية": "tr",
          "الهندية": "hi",
          "الصينية (مبسطة)": "zh-cn",
        };

        return Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    title:
                        Text("اختر لغة للترجمة", textAlign: TextAlign.center)),
                Divider(),
                ...langs.entries.map((e) {
                  return ListTile(
                    title: Text(e.key),
                    onTap: () {
                      Navigator.pop(context);
                      translateContent(e.value);
                    },
                  );
                }).toList(),
                ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text("استعادة النص الأصلي"),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      displayedText = originalText;
                      words = _splitWords(originalText);
                      highlightedIndex = -1;
                      currentWordIndex = 0;
                      isSpeaking = false;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Color picker simple helper: choose among predefined colors
  List<Color> pickerColors = [
    Colors.black,
    Colors.white,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.brown,
    Colors.deepPurple,
  ];

  void openSettingsPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.color.mainBrown,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.all(14),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الإعدادات",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),

                  // Dark mode
                  ListTile(
                    leading: Icon(Icons.dark_mode, color: Colors.white),
                    title: Text("الوضع الليلي",
                        style: TextStyle(color: Colors.white)),
                    trailing: Switch(
                      activeColor: context.color.mainGold,
                      activeTrackColor: Colors.yellow,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                      value: isDark,
                      onChanged: (v) {
                        setState(() => isDark = v);
                        setModalState(() {});
                      },
                    ),
                  ),

                  // Font family selection
                  ListTile(
                    leading: Icon(Icons.font_download, color: Colors.white),
                    title:
                        Text("نوع الخط", style: TextStyle(color: Colors.white)),
                    subtitle: Text(selectedFont,
                        style: TextStyle(color: Colors.white70)),
                    onTap: () {
                      Navigator.pop(context);
                      chooseFont();
                    },
                  ),

                  // Font size
                  ListTile(
                    leading: Icon(Icons.text_fields, color: Colors.white),
                    title:
                        Text("حجم الخط", style: TextStyle(color: Colors.white)),
                    subtitle: Slider(
                      value: fontSize,
                      min: 12,
                      max: 40,
                      divisions: 14,
                      label: fontSize.toStringAsFixed(0),
                      onChanged: (v) {
                        setState(() => fontSize = v);
                        setModalState(() {});
                      },
                    ),
                  ),

                  // Font color
                  ListTile(
                    leading: Icon(Icons.color_lens, color: Colors.white),
                    title:
                        Text("لون الخط", style: TextStyle(color: Colors.white)),
                    subtitle: SingleChildScrollView(
                      child: Row(
                        children: pickerColors.map((c) {
                          return GestureDetector(
                            onTap: () {
                              setState(() => fontColor = c);
                              setModalState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 6),
                              width: 23,
                              height: 23,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white70),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Brightness
                  ListTile(
                    leading: Icon(Icons.light_mode, color: Colors.white),
                    title:
                        Text("السطوع", style: TextStyle(color: Colors.white)),
                    subtitle: Slider(
                      value: brightness,
                      min: 0.1,
                      max: 1.0,
                      divisions: 9,
                      label: brightness.toStringAsFixed(2),
                      onChanged: (v) async {
                        try {
                          await ScreenBrightness().setScreenBrightness(v);
                        } catch (e) {
                          // ignore
                        }
                        setState(() => brightness = v);
                        setModalState(() {});
                      },
                    ),
                  ),

                  // Scroll speed
                  ListTile(
                    leading: Icon(Icons.speed, color: Colors.white),
                    title: Text("سرعة التمرير التلقائي",
                        style: TextStyle(color: Colors.white)),
                    subtitle: Slider(
                      value: scrollSpeed,
                      min: 0.5,
                      max: 3.0,
                      divisions: 25,
                      label: scrollSpeed.toStringAsFixed(1),
                      onChanged: (v) => setState(() => scrollSpeed = v),
                    ),
                  ),

                  // TTS voice picker
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text("اختيار صوت القارئ",
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text(tts.selectedVoice ?? "Auto",
                        style: TextStyle(color: Colors.white70)),
                    onTap: () {
                      Navigator.pop(context);
                      showVoicePicker();
                    },
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void chooseFont() {
    showDialog(
      context: context,
      builder: (_) {
        final fonts = ["IBMPlexArabic", "Cairo"];
        return AlertDialog(
          title: Text("اختر نوع الخط"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: fonts.map((f) {
              return ListTile(
                title: Text(f, style: TextStyle(fontFamily: f)),
                onTap: () {
                  setState(() => selectedFont = f);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void showVoicePicker() {
    showDialog(
      context: context,
      builder: (_) {
        final list = tts.voices.isNotEmpty
            ? tts.voices
            : [
                {"name": "default"}
              ];
        return AlertDialog(
          title: Text("اختر الصوت"),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: list.map((v) {
                final name = v is Map
                    ? (v["name"] ?? v["voice"] ?? v.toString())
                    : v.toString();
                return ListTile(
                  title: Text(name),
                  onTap: () {
                    try {
                      tts.setVoice(name);
                    } catch (e) {}
                    Navigator.pop(context);
                    setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    readTimer?.cancel();
    tts.stop();
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GuideModale category = guideModale.firstWhere(
      (e) => e.title == selectedFlag,
      orElse: () => guideModale.first,
    );

    final bg = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : fontColor;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: context.color.mainBrown,
            ),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                // The Title of the page
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      bottom: 10, start: 10, end: 10),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: context.color.mainGold,
                        borderRadius: BorderRadiusDirectional.circular(15)),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(right: 10),
                        //   child: GestureDetector(
                        //     onTap: (){
                        //       Navigator.pop(context);
                        //     },
                        //       child: Icon(
                        //     Icons.arrow_back,
                        //     color: context.color.mainBrown,
                        //   )),
                        // ),
                        Expanded(
                          child: Container(
                            // padding: EdgeInsets.only(left: 10),
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              category.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: isDark ? Colors.black : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        controller: scroll,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: List.generate(words.length, (i) {
                            final w = words[i] + " ";
                            final isHighlighted = i == highlightedIndex;
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              margin: EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                color: isHighlighted
                                    ? (isDark
                                        ? Colors.yellow[700]
                                        : Colors.yellowAccent)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                w,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color:
                                      isHighlighted ? Colors.black : textColor,
                                  fontFamily: selectedFont,
                                  height: 1.5,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 5),
                  // height: 80,
                  // padding: EdgeInsets.all(16),
                  color: context.color.mainGold,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // * Pause / Resume / Play Audio
                      FloatingActionButton(
                        heroTag: "playpause",
                        mini: true,
                        backgroundColor: context.color.mainBrown,
                        child:
                            Icon(isSpeaking ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          if (isSpeaking)
                            pauseReading();
                          else {
                            if (currentWordIndex > 0 &&
                                currentWordIndex < words.length) {
                              // resume by reading from currentWordIndex
                              setState(() {
                                isSpeaking = true;
                              });
                              startReading();
                            } else {
                              startReading();
                            }
                          }
                        },
                      ),
                      // * Small Space
                      SizedBox(width: 5),
                      // * Stop Audio
                      FloatingActionButton(
                        heroTag: "stop",
                        mini: true,
                        backgroundColor: context.color.mainBrown,
                        child: Icon(Icons.stop),
                        onPressed: stopReading,
                      ),
                      // * Small Space
                      SizedBox(width: 5),
                      // * Share Text
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          Share.share(originalText);
                        },
                        child: const Icon(Icons.share),
                        backgroundColor: context.color.mainBrown,
                      ),
                      // * small Space
                      SizedBox(
                        width: 5,
                      ),
                      // * Copy Text
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: originalText));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("تم نسخ النص")),
                          );
                        },
                        child: const Icon(Icons.copy),
                        backgroundColor: context.color.mainBrown,
                      ),
                      // * Small Space
                      SizedBox(width: 5),
                      // * Translate (quick)
                      FloatingActionButton(
                        heroTag: "translate_quick",
                        mini: true,
                        backgroundColor: context.color.mainBrown,
                        child: Icon(Icons.translate),
                        onPressed: openTranslateMenu,
                      ),
                      // * Large Space
                      SizedBox(
                        width: 20,
                      ),
                      // Open settings
                      FloatingActionButton(
                        heroTag: "settings",
                        backgroundColor: context.color.mainBrown,
                        child: Icon(Icons.menu_book),
                        onPressed: openSettingsPanel,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
