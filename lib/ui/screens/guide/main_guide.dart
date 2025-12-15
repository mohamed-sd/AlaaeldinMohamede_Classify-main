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
        GuideTitleModel(text: 'تسجيل الشركات', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'تسجيل اسماء الاعمال', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
      ],
    ),
    GuideCatModale(
      flag: "وزارة الاستثمار",
      titles: [
        GuideTitleModel(text: 'طلب ترخيص جديد', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
      ],
    ),
    GuideCatModale(
      flag: "وزارة المعادن",
      titles: [
        GuideTitleModel(text: 'طلب الترخيص', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'رخصة التعدين', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'تراخيص المحليات', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'التعدين النهري', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'عقود التعدين', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),

      ],
    ),

    GuideCatModale(
      flag: "الولايات والمحليات",
      titles: [
        GuideTitleModel(text: 'إصدار شهادات التعدين', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'تصديق مربعات التعدين', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
      ],
    ),

    GuideCatModale(
      flag: "الاجراءات البنكية",
      titles: [
        GuideTitleModel(text: 'الحساب الشخصي', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'حسابات الشركات', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'تصدير الذهب', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
      ],
    ),
    GuideCatModale(
      flag: "شرطة المرور العامة",
      titles: [
        GuideTitleModel(text: 'ترخيص الافراد', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
        GuideTitleModel(text: 'ترخيص الشركات', imagePath: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%B7%D9%84%D8%A8%20%D8%AA%D8%B1%D8%AE%D9%8A%D8%B5.jpeg?alt=media&token=a20e8796-c5cb-486b-9337-dcac854ce666'),
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
