import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/model/equipation/guide_modale.dart';
import 'package:eClassify/ui/screens/widgets/equipation_widgets/main_guide_card.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MainGuide extends StatefulWidget {
  final String flag;
  const MainGuide({
    Key? key,
    required this.flag,
  }) : super(key: key);
  static Route route(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => MainGuide(
        flag: args['flag'] as String,
      ),
    );
  }

  @override
  State<MainGuide> createState() => _MainGuideState();
}

class _MainGuideState extends State<MainGuide> {
  bool isGrid = false; // لتحديد نوع العرض Grid or List

  List<GuideCatModale> cats = [
    GuideCatModale(
        flag: "الاجراءات الحكومية",
        titles: ['تسجيل الشركات', 'تسجيل اسماء الاعمال']),
    GuideCatModale(flag: "وزارة الاستثمار", titles: ['طلب ترخيص جديد']),
    GuideCatModale(
        flag: "وزارة المعادن",
        titles: ['طلب الترخيص', 'رخصة التعدين', 'تراخيص المحليات']),
    GuideCatModale(
        flag: "الاجراءات البنكية", titles: ['الحساب الشخصي', 'حسابات الشركات']),
    GuideCatModale(
        flag: "شرطة المرور العامة", titles: ['ترخيص الافراد', 'ترخيص الشركات']),
  ];

  @override
  Widget build(BuildContext context) {
    final String selectedFlag = widget.flag;

    final GuideCatModale category =
        cats.firstWhere((e) => e.flag == selectedFlag);

    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        backgroundColor: context.color.mainBrown,
        title: Text(widget.flag),
        actions: [
          // عرض على شكل Grid
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = true;
              });
            },
            icon: Icon(
              Icons.grid_view,
              color: isGrid ? Colors.white : Colors.white70,
            ),
          ),

          // عرض على شكل List
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = false;
              });
            },
            icon: Icon(
              Icons.view_list,
              color: !isGrid ? Colors.white : Colors.white70,
            ),
          )
        ],
      ),
      backgroundColor: context.color.mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),

        // تبديل تلقائي بين GridView و ListView
        child: isGrid
            ? buildGridView(context, category)
            : buildListView(context, category),
      ),
    );
  }

  // ==========================
  //     GridView Builder
  // ==========================
  Widget buildGridView(BuildContext context, GuideCatModale category) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // عدد الأعمدة
          crossAxisSpacing: 20, // المسافة بين الأعمدة
        ),
        itemCount: category.titles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.detailes,
                arguments: {
                  'title': category.titles[index],
                },
              );
            },
            child: MainGuideCard(
              title: category.titles[index],
              urlimg:
                  "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
            ),
          );
        },
      ),
    );
  }

  // ==========================
  //       ListView Builder
  // ==========================
  Widget buildListView(BuildContext context, GuideCatModale category) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: category.titles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.detailes,
                arguments: {
                  'title': category.titles[index],
                },
              );
            },
            child: MainListCard(
              title: category.titles[index],
              urlimg:
                  "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
            ),
          );
        },
      ),
    );
  }
}
