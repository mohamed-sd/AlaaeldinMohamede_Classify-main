import 'dart:async';
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
  final String content = """

التعريف ورخص البحث/الاستكشاف في السودان:
الرُخْص مُنحت لأنواع عدة: رخصة عامة للبحث، رخصة استكشاف مطلقة، عقد تعدين، تعدين صغير، استخراج معادن أو صخور صناعية وغيرها.
رخصة البحث العام تمنح لمن يُخوّل له الدخول إلى المنطقة المرخصة وأخذ عينات سطحية لأغراض الدراسة، مع استثناء المناطق المرخّصة مسبقاً للاستكشاف الحصري أو المرتبطة بعقد تعدين.
رخصة الاستكشاف المطلقة تمنح الحق في إجراء المسوحات الجيولوجية/الجيوكيميائية/الجيوفيزيائية، وأعمال الحفر التنقيبي وأخذ العينات اللازمة للتحليل والدراسات الفنية.

الشروط والإجراءات الأساسية للتقديم:
- يُقدَّم الطلب إلى الجهة المختصة المعنية بالتعدين.
- يجب أن يتضمن الطلب تحديد المعدن أو المواد التعدينية المطلوب البحث عنها.
- في حالة رخصة الاستكشاف المطلقة: يُقدَّم برنامج عمل للاستكشاف يتضمّن الأعمال المقترحة، المعدات، الجدول الزمني، والتكاليف المتوقعة.
- يُطلب إثبات الكفاءة الفنية والقدرة المالية للمتقدم سواء كان شركة أو شخصًا.
- تُوقّع الرخصة أو العقد من الوزير المختص أو الجهة المخوّلة بعد موافقة اللجنة المعنية.

الرسوم:
- توجد رسوم طلب ونظر ورسوم إصدار لرخصة البحث العام، وتختلف الرسوم حسب نوع الرخصة أو العقد.

الالتزامات والقيود:
- حامل رخصة الاستكشاف المطلقة له الحق الحصري في إجراء أعمال الاستكشاف في المنطقة المرخّصة.
- إذا اكتُشف مورد معدني جدير بالاستخراج، يمكن تحويل الترخيص أو إبرام عقد تعدين أو استغلال بحسب القانون.
- يُمنع التعدين أو الحفر أو استخراج المعادن دون رخصة سارية أو عقد تعدين، ومخالفات ذلك تُعاقب قانونيًا.
""";

  @override
  State<Detailes> createState() => _DetailesState();
}

class _DetailesState extends State<Detailes> {
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
  String originalText = "";

  // translation state
  bool translating = false;

  @override
  void initState() {
    super.initState();
    originalText = widget.content;
    displayedText = widget.content;
    words = _splitWords(displayedText);
    tts.init();
    _loadInitialBrightness();
  }

  List<String> _splitWords(String text) {
    final w =
        text.split(RegExp(r'\s+')).where((s) => s.trim().isNotEmpty).toList();
    return w;
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
                      words = _splitWords(displayedText);
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
        final fonts = ["Cairo", "Tajawal", "Amiri"];
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
    final bg = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : fontColor;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.color.mainBrown,
          title: Text(
            " إجراءات رخصة البحث العامة ",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.content));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم نسخ النص")),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share(widget.content);
              },
            ),
            // IconButton(icon: Icon(Icons.settings), onPressed: openSettingsPanel),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
                              color: isHighlighted ? Colors.black : textColor,
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
              padding: EdgeInsets.only(bottom: 20 , top: 5),
              // height: 80,
              // padding: EdgeInsets.all(16),
              color: context.color.mainGold,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Pause / Resume / Play
                    FloatingActionButton(
                      heroTag: "playpause",
                      mini: true,
                      backgroundColor: context.color.mainBrown,
                      child: Icon(isSpeaking ? Icons.pause : Icons.play_arrow),
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
                    SizedBox(width: 10),
                    // Stop
                    FloatingActionButton(
                      heroTag: "stop",
                      mini: true,
                      backgroundColor: context.color.mainBrown,
                      child: Icon(Icons.stop),
                      onPressed: stopReading,
                    ),
                    SizedBox(width: 10),
                    // Translate (quick)
                    FloatingActionButton(
                      heroTag: "translate_quick",
                      mini: true,
                      backgroundColor: context.color.mainBrown,
                      child: Icon(Icons.translate),
                      onPressed: openTranslateMenu,
                    ),
                    SizedBox(width: 10),
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
        )
        // Stack(
        //   children: [
        //     Container(color: bg),
        //     Padding(
        //       padding: EdgeInsets.only(top: 20 , bottom: 80 , right: 10 , left: 10),
        //       child: SingleChildScrollView(
        //         controller: scroll,
        //         child: Wrap(
        //           alignment: WrapAlignment.start,
        //           children: List.generate(words.length, (i) {
        //             final w = words[i] + " ";
        //             final isHighlighted = i == highlightedIndex;
        //             return Container(
        //               padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        //               margin: EdgeInsets.symmetric(vertical: 2),
        //               decoration: BoxDecoration(
        //                 color: isHighlighted ? (isDark ? Colors.yellow[700] : Colors.yellowAccent) : Colors.transparent,
        //                 borderRadius: BorderRadius.circular(4),
        //               ),
        //               child: Text(
        //                 w,
        //                 textDirection: TextDirection.rtl,
        //                 style: TextStyle(
        //                   fontSize: fontSize,
        //                   color: isHighlighted ? Colors.black : textColor,
        //                   fontFamily: selectedFont,
        //                   height: 1.5,
        //                 ),
        //               ),
        //             );
        //           }),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 18,
        //       right: 18,
        //       child: Container(
        //         alignment: Alignment.center,
        //         color: context.color.mainGold,
        //         child: Row(
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             // Pause / Resume / Play
        //             FloatingActionButton(
        //               heroTag: "playpause",
        //               mini: true,
        //               backgroundColor: Colors.blue,
        //               child: Icon(isSpeaking ? Icons.pause : Icons.play_arrow),
        //               onPressed: () {
        //                 if (isSpeaking) pauseReading();
        //                 else {
        //                   if (currentWordIndex > 0 && currentWordIndex < words.length) {
        //                     // resume by reading from currentWordIndex
        //                     setState(() {
        //                       isSpeaking = true;
        //                     });
        //                     startReading();
        //                   } else {
        //                     startReading();
        //                   }
        //                 }
        //               },
        //             ),
        //
        //             SizedBox(width: 10),
        //
        //             // Stop
        //             FloatingActionButton(
        //               heroTag: "stop",
        //               mini: true,
        //               backgroundColor: Colors.red,
        //               child: Icon(Icons.stop),
        //               onPressed: stopReading,
        //             ),
        //
        //             SizedBox(width: 10),
        //
        //             // Translate (quick)
        //             FloatingActionButton(
        //               heroTag: "translate_quick",
        //               mini: true,
        //               backgroundColor: Colors.green,
        //               child: Icon(Icons.translate),
        //               onPressed: openTranslateMenu,
        //             ),
        //
        //             SizedBox(width: 10),
        //
        //             // Open settings
        //             FloatingActionButton(
        //               heroTag: "settings",
        //               backgroundColor: Colors.blueAccent,
        //               child: Icon(Icons.menu_book),
        //               onPressed: openSettingsPanel,
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}

// class Detailes extends StatefulWidget {
//   const Detailes({super.key});
//   @override
//   State<Detailes> createState() => _DetailesWidgetState();
// }
//
// class _DetailesWidgetState extends State<Detailes> {
//   @override
//   Widget build(BuildContext context) {
//     int font_size = 10;
//
//     String text = '''
// التعريف ورخص البحث/الاستكشاف في السودان:
// الرُخْص مُنحت لأنواع عدة: رخصة عامة للبحث، رخصة استكشاف مطلقة، عقد تعدين، تعدين صغير، استخراج معادن أو صخور صناعية وغيرها.
// رخصة البحث العام تمنح لمن يُخوّل له الدخول إلى المنطقة المرخصة وأخذ عينات سطحية لأغراض الدراسة، مع استثناء المناطق المرخّصة مسبقاً للاستكشاف الحصري أو المرتبطة بعقد تعدين.
// رخصة الاستكشاف المطلقة تمنح الحق في إجراء المسوحات الجيولوجية/الجيوكيميائية/الجيوفيزيائية، وأعمال الحفر التنقيبي وأخذ العينات اللازمة للتحليل والدراسات الفنية.
//
// الشروط والإجراءات الأساسية للتقديم:
// - يُقدَّم الطلب إلى الجهة المختصة المعنية بالتعدين.
// - يجب أن يتضمن الطلب تحديد المعدن أو المواد التعدينية المطلوب البحث عنها.
// - في حالة رخصة الاستكشاف المطلقة: يُقدَّم برنامج عمل للاستكشاف يتضمّن الأعمال المقترحة، المعدات، الجدول الزمني، والتكاليف المتوقعة.
// - يُطلب إثبات الكفاءة الفنية والقدرة المالية للمتقدم سواء كان شركة أو شخصًا.
// - تُوقّع الرخصة أو العقد من الوزير المختص أو الجهة المخوّلة بعد موافقة اللجنة المعنية.
//
// الرسوم:
// - توجد رسوم طلب ونظر ورسوم إصدار لرخصة البحث العام، وتختلف الرسوم حسب نوع الرخصة أو العقد.
//
// الالتزامات والقيود:
// - حامل رخصة الاستكشاف المطلقة له الحق الحصري في إجراء أعمال الاستكشاف في المنطقة المرخّصة.
// - إذا اكتُشف مورد معدني جدير بالاستخراج، يمكن تحويل الترخيص أو إبرام عقد تعدين أو استغلال بحسب القانون.
// - يُمنع التعدين أو الحفر أو استخراج المعادن دون رخصة سارية أو عقد تعدين، ومخالفات ذلك تُعاقب قانونيًا.
// ''';
//
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         backgroundColor: context.color.mainGold,
//         appBar: AppBar(
//           backgroundColor: context.color.mainGold,
//           automaticallyImplyLeading: false,
//           title: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: 60,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: context.color.mainBrown,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: InkWell(
//                   child: Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: SafeArea(
//           top: true,
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(15, 10, 10, 10),
//                     child: Material(
//                       color: Colors.transparent,
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Padding(
//                           padding:
//                               EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 // The title
//                                 Container(
//                                   width: double.infinity,
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 10),
//                                   margin: EdgeInsets.only(
//                                       top: 20, right: 10, left: 10),
//                                   decoration: BoxDecoration(
//                                       color: context.color.mainGold,
//                                       borderRadius:
//                                           BorderRadiusDirectional.circular(15)),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'اجراءات رخصة البحث العامة',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                       MenueIconButton(),
//                                       InkWell(
//                                           onTap: (){
//                                             Navigator.pushNamed(context, Routes.readerPage);
//                                           },
//                                           child:Icon(Icons.add_box)),
//                                     ],
//                                   ),
//                                 ),
//                                 // The text
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30, vertical: 20),
//                                   child: Text(
//                                     text,
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
class MenueItems extends StatelessWidget {
  const MenueItems({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int font_size = 10;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          MenueItem(
            color: const Color.fromARGB(255, 239, 199, 79),
            item: "الترجمة",
            icon: Icon(
              Icons.translate_outlined,
              size: 18,
            ),
          ),
          Rular(),
          MenueItem(
            color: const Color.fromARGB(255, 240, 212, 128),
            item: "السطوع",
            icon: Icon(
              Icons.brightness_medium_rounded,
              size: 18,
            ),
          ),
          Rular(),
          MenueItem(
            color: const Color.fromARGB(255, 239, 199, 79),
            item: "حجم الخط",
            icon: Icon(
              Icons.format_size,
              size: 18,
            ),
          ),
          Rular(),
          MenueItem(
            color: const Color.fromARGB(255, 240, 212, 128),
            item: "المشاركة",
            icon: Icon(
              Icons.share,
              size: 18,
            ),
          ),
          Rular(),
          InkWell(
            onTap: () {},
            child: MenueItem(
              color: const Color.fromARGB(255, 239, 199, 79),
              item: " إعادة ضبط ",
              icon: Icon(
                Icons.refresh_outlined,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
class MenueItem extends StatelessWidget {
  String item;
  Color color;
  Icon icon;
  MenueItem({required this.item, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(item),
        ],
      ),
    );
  }
}
