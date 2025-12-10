import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/screens/widgets/equipation_widgets/main_guide_card.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MainGuide extends StatelessWidget {
  const MainGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.mainBrown,
        title: Text("وزارة المعادن"),


      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          children: [
            // The main guide wedgit :
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.guide);
              },
              child: MainGuideCard(
                title: "تراخيص التعدين",
                urlimg: "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",

              ),
            ),
            MainGuideCard(
              title: "عقود التعدين",
              urlimg: "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(2).jpg?alt=media&token=f86a02f4-ab02-42b8-944d-05137a797523",

            ),
          ],
        ),
      ),
    );
  }
}
