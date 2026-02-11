import 'package:eClassify/app/app_theme.dart';
import 'package:eClassify/app/routes.dart';
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
import "package:eClassify/ui/screens/ad_details_screen.dart";

class Jobsdetailswedgit extends StatefulWidget {
  const Jobsdetailswedgit({Key? key}) : super(key: key);

  static const String routeName = 'comingSoon';
  static const String routePath = '/comingSoon';

  @override
  State<Jobsdetailswedgit> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<Jobsdetailswedgit> {
  int currentPage = 0;
  int selectTab = 0;
  final PageController _pageController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _rating = 4;

  List<String> images = [
    'assets/profile.jpg',
    'assets/profile.jpg',
    'assets/profile.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
        ),
        body: SafeArea(
          child: Scaffold(
            backgroundColor: context.color.mainColor,
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  // Job title
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
                    height: 10,
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                                blurStyle: BlurStyle.normal),
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(children: [
                              // Image Slider
                              setImageViewer(),
                              Opacity(
                                opacity: 0.9,
                                child: Align(
                                  alignment: AlignmentDirectional(1, -1),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 15, 10, 0),
                                    child: Container(
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            2, 0, 2, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(3, 0, 3, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color: Color(0xFF5C5C5C),
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    "12",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: context.color.mainGold,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        "100",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: context.color.mainGold,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        "12/2/2025",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(5, (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _rating = index + 1;
                                              });
                                            },
                                            child: Icon(
                                              index < _rating
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.amber,
                                              size: 20,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 5, 0),
                                          child: Text(
                                            '139 تقييم',
                                            style: TextStyle(
                                              fontSize: 12,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                'عرض جمييع التقييمات',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  letterSpacing: 0.0,
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                      child: Row(
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 2.5),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.grey,
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  'احمد عبد الوهاب',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2.5, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.grey,
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  'Sudan@gmail.com',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(),
                                                ),
                                              ),
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
                              onTap: () {
                                Navigator.pushNamed(context, Routes.jobProfile);
                              },
                              child: Container(
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 241, 239, 239),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('حساب المعلن',
                                          style: TextStyle(
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2.5),
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
                            details_row('القسم', 'التوظيف'),
                            details_row('نوع الاعلان', 'بحث عن وظيفة'),
                            details_row('المدينة', 'الخرطوم'),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            details_row('الفئة الفرعية', 'فنيون وعمال'),
                            details_row('الجنس', 'ذكر'),
                            details_row('سنوات الخبرة', '3 سنوات'),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            details_row('المؤهل العلمي', 'عالي'),
                            details_row('الراتب المتوقع', '1500 - 2500'),
                            details_row('الجنسية', 'سوداني'),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            details_row('نوع الوظيفي', 'دوام كامل'),
                            details_row(' المستوى الوظيفي ', 'ذو خبرة (إداري)'),
                            details_row('رخصة القيادة', 'نعم'),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2.5),
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
                            border: Border.all(color: Colors.black12, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                              'نبحث عن مشرف ذو خبرة في مجال التعدين بخبرة لا تقل عن 5 اعوام بحيث يكون قادرا علي المهام الاشرافية والادارية بحرفية ويجب ان يكون لديه ماجستير في مجال الادارة وشهادات خبرة من الشركات السابقة للعمل'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      // Add download CV functionality
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: context.color.mainGold,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(12, 0, 0, 0),
                              offset: Offset(0, 2),
                              blurRadius: 10,
                              spreadRadius: 4,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تحميل السيرة الذاتية',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(Icons.cloud_download_sharp)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded details_row(String title, String text) {
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
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setImageViewer() {
    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(children: [
          PageView.builder(
            itemCount: images.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00FFFFFF),
                      Color(0x00FFFFFF),
                      Color(0x00FFFFFF),
                      Color(0x7F060606)
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.darken,
                child: InkWell(
                  onTap: () {
                    // Add image tap functionality
                  },
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => buildDot(index),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: currentPage == index ? 12 : 8,
      height: currentPage == index ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? context.color.mainGold : Colors.white,
        border: Border.all(
          color: context.color.mainGold ?? Colors.amber,
          width: 1.5,
        ),
      ),
    );
  }
}
