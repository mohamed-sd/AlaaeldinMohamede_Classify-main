import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MainGuideCard extends StatelessWidget {
  String title;
  MainGuideCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.color.mainBrown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          )),
      child: Container(
        decoration: BoxDecoration(
            color: context.color.mainGold,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomRight: Radius.circular(100),
            )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
