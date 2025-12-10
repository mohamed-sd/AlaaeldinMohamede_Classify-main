import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/screens/widgets/equipation_widgets/main_guide_card.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MainGuide extends StatefulWidget {
  const MainGuide({super.key});

  @override
  State<MainGuide> createState() => _MainGuideState();
}

class _MainGuideState extends State<MainGuide> {
  bool isGrid = false; // لتحديد نوع العرض Grid or List

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        backgroundColor: context.color.mainBrown,
        title: const Text("وزارة المعادن"),
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
        child: isGrid ? buildGridView(context) : buildListView(context),
      ),
    );
  }

  // ==========================
  //     GridView Builder
  // ==========================
  Widget buildGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      shrinkWrap: false,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.guide);
          },
          child:  MainGuideCard(
            title: " تراخيص التعدين",
            urlimg:
            "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
          ),
        ),

         MainGuideCard(
          title: "عقود التعدين",
          urlimg:
          "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(2).jpg?alt=media&token=f86a02f4-ab02-42b8-944d-05137a797523",
        ),
        
      ],
    );
  }

  // ==========================
  //       ListView Builder
  // ==========================
  Widget buildListView(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.guide);
            },
            child:  MainListCard(
              title: " تراخيص التعدين",
              urlimg:
              "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
            ),
          ),

          const SizedBox(height: 12),

          MainListCard(
            title: "عقود التعدين",
            urlimg:
            "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(2).jpg?alt=media&token=f86a02f4-ab02-42b8-944d-05137a797523",
          ),
        ],
      ),
    );
  }
}
