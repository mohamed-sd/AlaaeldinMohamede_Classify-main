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
          crossAxisSpacing: 20,
          children: [
            // The main guide wedgit :
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.guide);
              },
              child: MainGuideCard(
                title: "تراخيص التعدين",
              ),
            ),
            MainGuideCard(
              title: "عقود التعدين واستخراج الصخور والمعادن الصناعية",
            ),
          ],
        ),
      ),
    );
  }
}
