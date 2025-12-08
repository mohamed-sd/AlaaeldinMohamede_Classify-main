import 'package:eClassify/ui/screens/widgets/equipation_widgets/popup_menue/menue_icon_button.dart';
import 'package:eClassify/ui/screens/widgets/equipation_widgets/popup_menue/menue_item_rular.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class Detailes extends StatefulWidget {
  const Detailes({super.key});
  @override
  State<Detailes> createState() => _DetailesWidgetState();
}

class _DetailesWidgetState extends State<Detailes> {
  @override
  Widget build(BuildContext context) {
    int font_size = 10;

    String text = '''
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
''';

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: context.color.mainGold,
        appBar: AppBar(
          backgroundColor: context.color.mainGold,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: context.color.mainBrown,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 10, 10),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // The title
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  margin: EdgeInsets.only(
                                      top: 20, right: 10, left: 10),
                                  decoration: BoxDecoration(
                                      color: context.color.mainGold,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(15)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'اجراءات رخصة البحث العامة',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      MenueIconButton(),
                                    ],
                                  ),
                                ),
                                // The text
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
