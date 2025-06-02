import 'package:eClassify/app/app_theme.dart';
import 'package:eClassify/data/cubits/favorite/favorite_cubit.dart';
import 'package:eClassify/data/cubits/favorite/manage_fav_cubit.dart';
import 'package:eClassify/data/cubits/system/app_theme_cubit.dart';
import 'package:eClassify/data/model/item/item_model.dart';
import 'package:eClassify/data/repositories/favourites_repository.dart';
import 'package:eClassify/ui/screens/exchange/money_exchange.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/app_icon.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Jobsdetailswedgit extends StatefulWidget {
  const Jobsdetailswedgit({Key? key}) : super(key: key);

  static const String routeName = 'comingSoon';
  static const String routePath = '/comingSoon';

  @override
  State<Jobsdetailswedgit> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<Jobsdetailswedgit> {
  int selectTab = 0;
  final PageController _pageController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: context.color.mainColor,
        appBar: UiUtils.buildAppBar(
          context,
          title: ' تفاصيل الوظيفة ',
          showBackButton: true,
          backgroundColor: context.color.mainBrown,
          // bottomHeight: 60,
          // bottom: [
          //   SizedBox(
          //     height: 5,
          //   ),
          //   SizedBox(
          //       width: context.screenWidth,
          //       height: 50,
          //       child: ListView(
          //           shrinkWrap: true,
          //           padding: const EdgeInsetsDirectional.fromSTEB(18, 5, 18, 2),
          //           scrollDirection: Axis.horizontal,
          //           children: [
          //             customTab(context,
          //                 isSelected: (selectTab == 0),
          //                 name: ' عارض وظيفة ', onTap: () {
          //                   selectTab = 0;
          //                   setState(() {});
          //                   _pageController.jumpToPage(0);
          //                 }, onDoubleTap: () {}),
          //             SizedBox(
          //               width: 8,
          //             ),
          //             customTab(context,
          //                 isSelected: (selectTab == 1),
          //                 name: ' باحث عن وظيفة ', onTap: () {
          //                   selectTab = 1;
          //                   setState(() {});
          //                   _pageController.jumpToPage(1);
          //                 }, onDoubleTap: () {}),
          //             SizedBox(
          //               width: 8,
          //             ),
          //             customTab(context,
          //                 isSelected: (selectTab == 2),
          //                 name: ' باحث عن تدريب ', onTap: () {
          //                   selectTab = 2;
          //                   setState(() {});
          //                   _pageController.jumpToPage(2);
          //                 }, onDoubleTap: () {}),
          //             SizedBox(
          //               width: 8,
          //             ),
          //           ])),
          // ],
        ),
        body: SafeArea(
          child: Scaffold(
            backgroundColor: context.color.mainColor,
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: context.color.mainGold,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'مشرف ذو خبرة في مجال التعدين',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(12, 0, 0, 0),
                            offset: Offset(0, 2),
                            blurRadius: 10,
                            spreadRadius: 4,
                          )
                        ]),
                    child:  Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/profile.jpg",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2.5),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 2,
                                                color: Colors.grey,
                                              )
                                            ),
                                            child: Text('احمد عبد الوهاب' , textAlign: TextAlign.center ,  style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 2.5, 0, 0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.grey,
                                                )
                                            ),
                                            child: Text('Sudan@gmail.com' , textAlign: TextAlign.center ,  style: TextStyle(
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              width: 120,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 241, 239, 239),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'حساب المعلن',
                                        style: TextStyle(
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5 , horizontal: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(12, 0, 0, 0),
                            offset: Offset(0, 2),
                            blurRadius: 10,
                            spreadRadius: 4,
                          )
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2.5),
                          padding: EdgeInsets.symmetric(vertical: 2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: context.color.mainGold,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'المعلومات الاساسية',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            details_row('القسم','التوظيف'),
                            details_row('نوع الاعلان','بحث عن وظيفة'),
                            details_row('المدينة','الخرطوم'),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            details_row('الفئة الفرعية','فنيون وعمال'),
                            details_row('الجنس','ذكر'),
                            details_row('سنوات الخبرة','3 سنوات'),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            details_row('المؤهل العلمي','عالي'),
                            details_row('الراتب المتوقع','1500 - 2500'),
                            details_row('الجنسية','سوداني'),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            details_row('نوع الوظيفي','دوام كامل'),
                            details_row(' المستوى الوظيفي ','ذو خبرة (إداري)'),
                            details_row('رخصة القيادة','نعم'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(12, 0, 0, 0),
                            offset: Offset(0, 2),
                            blurRadius: 10,
                            spreadRadius: 4,
                          )
                        ]),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5,vertical: 2.5),
                          padding: EdgeInsets.symmetric(vertical: 2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: context.color.mainGold,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            ' معلومات الوظيفة ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 2.5, 5, 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 2
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text('نبحث عن مشرف ذو خبرة في مجال التعدين بخبرة لا تقل عن 5 اعوام بحيث يكون قادرا علي المهام الاشرافية والادارية بحرفية ويجب ان يكون لديه ماجستير في مجال الادارة وشهادات خبرة من الشركات السابقة للعمل'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded details_row(String title , String text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(2.5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              )),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 234, 232, 232),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
