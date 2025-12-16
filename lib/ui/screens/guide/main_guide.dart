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

  // List<GuideCatModale> cats = [
  //   GuideCatModale(
  //       flag: "الاجراءات الحكومية",
  //       titles: ['تسجيل الشركات', 'تسجيل اسماء الاعمال']),
  //   GuideCatModale(flag: "وزارة الاستثمار", titles: ['طلب ترخيص جديد']),
  //   GuideCatModale(
  //       flag: "وزارة المعادن",
  //       titles: ['طلب الترخيص', 'رخصة التعدين', 'تراخيص المحليات']),
  //   GuideCatModale(
  //       flag: "الاجراءات البنكية", titles: ['الحساب الشخصي', 'حسابات الشركات', 'تصدير الذهب']),
  //   GuideCatModale(
  //       flag: "شرطة المرور العامة", titles: ['ترخيص الافراد', 'ترخيص الشركات']),
  // ];
  //


  List<GuideCatModale> cats = [
    GuideCatModale(
      flag: "الاجراءات الحكومية",
      titles: [
        GuideTitleModel(text: 'تسجيل الشركات', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F1-%20%D8%AA%D8%B3%D8%AC%D9%8A%D9%84%20%D8%A7%D9%84%D8%B4%D8%B1%D9%83%D8%A7%D8%AA.jpeg?alt=media&token=c2893225-913f-48e9-9e19-ba4b84670e3b'),
        GuideTitleModel(text: 'تسجيل اسماء الاعمال', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F2-%20%D8%AA%D8%B3%D8%AC%D9%8A%D9%84%20%D8%A7%D8%B3%D9%85%D8%A7%D8%A1%20%D8%A7%D9%84%D8%B9%D9%85%D9%84.jpeg?alt=media&token=e7686706-ca98-4533-956a-9e7917cc1663'),
      ],
    ),
    GuideCatModale(
      flag: "وزارة الاستثمار",
      titles: [
        GuideTitleModel(text: 'طلب ترخيص جديد', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5%20%D8%AC%D8%AF%D9%8A%D8%AF.jpeg?alt=media&token=1b49cfbb-3059-4ceb-9089-3ae8db435390'),
      ],
    ),
    GuideCatModale(
      flag: "وزارة المعادن",
      titles: [
        GuideTitleModel(text: 'طلب الترخيص', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'رخصة التعدين', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F2-%20%D8%B1%D8%AE%D8%B5%D8%A9%20%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg?alt=media&token=b60bdead-38ef-4fc4-8ae3-3cca9790cddc'),
        GuideTitleModel(text: 'تراخيص المحليات', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F3-%20%D8%AA%D8%B1%D8%A7%D8%AE%D9%8A%D8%B5%20%D8%A7%D9%84%D9%85%D8%AD%D9%84%D9%8A%D8%A7%D8%AA.jpeg?alt=media&token=cfcc1666-0ba1-4ba3-a596-ffaaae9356fe'),
        // GuideTitleModel(text: 'التعدين النهري', imagePath: 'https:b-9337-dcac854ce666'),
        // GuideTitleModel(text: 'عقود التعدين', imagePath: 'https:dcac854ce666'),

      ],
    ),

    GuideCatModale(
      flag: "الولايات والمحليات",
      titles: [
        GuideTitleModel(text: 'إصدار شهادات التعدين', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F1-%20%D8%A7%D8%B5%D8%AF%D8%A7%D8%B1%20%D8%B4%D9%87%D8%A7%D8%AF%D8%A7%D8%AA%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg?alt=media&token=09602d3f-8441-4b6b-b834-182051f379d1'),
        GuideTitleModel(text: 'تصديق مربعات التعدين', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F2-%20%D8%AA%D8%B5%D8%AF%D9%8A%D9%82%20%D9%85%D8%B1%D8%A8%D8%B9%D8%A7%D8%AA%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg?alt=media&token=a488d394-dfe2-4ec8-a7fe-07e8d40fd908'),
      ],
    ),

    GuideCatModale(
      flag: "الاجراءات البنكية",
      titles: [
        GuideTitleModel(text: 'الحساب الشخصي', imagePath: '337-dcac854ce666'),
        GuideTitleModel(text: 'حسابات الشركات', imagePath: 'b-9337-dcac854ce666'),
        GuideTitleModel(text: 'تصدير الذهب', imagePath: 'cac854ce666'),
      ],
    ),
    GuideCatModale(
      flag: "شرطة المرور العامة",
      titles: [
        GuideTitleModel(text: 'ترخيص الافراد', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F1-%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5%20%D8%A7%D9%84%D8%A7%D9%81%D8%B1%D8%A7%D8%AF.jpeg?alt=media&token=f37f255e-29c4-42a4-9527-67e7b1184ae3'),
        GuideTitleModel(text: 'ترخيص الشركات', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F2-%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5%20%D8%A7%D9%84%D8%B4%D8%B1%D9%83%D8%A7%D8%AA.jpeg?alt=media&token=0106e06f-a8df-4cdd-9d6e-685f2f7d9b74'),
      ],
    ),
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
                  'title': category.titles[index].text,
                },
              );
            },
            child: MainGuideCard(
              title: category.titles[index].text,
              urlimg:
                  category.titles[index].imagePath,
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
                  'title': category.titles[index].text,
                },
              );
            },
            child: MainListCard(
              title: category.titles[index].text,
              urlimg: category.titles[index].imagePath
                   ,
            ),
          );
        },
      ),
    );
  }
}
