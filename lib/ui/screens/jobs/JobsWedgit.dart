import 'package:cached_network_image/cached_network_image.dart';
import 'package:eClassify/app/app_theme.dart';
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/cubits/favorite/favorite_cubit.dart';
import 'package:eClassify/data/cubits/favorite/manage_fav_cubit.dart';
import 'package:eClassify/data/cubits/system/app_theme_cubit.dart';
import 'package:eClassify/data/model/item/item_model.dart';
import 'package:eClassify/data/repositories/favourites_repository.dart';
import 'package:eClassify/ui/screens/exchange/money_exchange.dart';
import 'package:eClassify/ui/screens/widgets/equipation_widgets/add_new_adds.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/app_icon.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Jobswedgit extends StatefulWidget {
  const Jobswedgit({Key? key}) : super(key: key);

  static const String routeName = 'comingSoon';
  static const String routePath = '/comingSoon';

  @override
  State<Jobswedgit> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<Jobswedgit> {
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
          title: ' الوظائف الإدارية ',
          showBackButton: true,
          backgroundColor: context.color.mainBrown,
          bottomHeight: 70,
          bottom: [
            SizedBox(
              height: 16,
            ),
            SizedBox(
                width: context.screenWidth,
                height: 50,
                child: Row(children: [
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: customJobTab(context,
                        isSelected: (selectTab == 0),
                        name: ' الوظائف المعروضة ', onTap: () {
                      selectTab = 0;
                      setState(() {});
                      _pageController.jumpToPage(0);
                    }, onDoubleTap: () {}),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: customJobTab(context,
                          isSelected: (selectTab == 1),
                          name: ' الوظائف المطلوبة ', onTap: () {
                    selectTab = 1;
                    setState(() {});
                    _pageController.jumpToPage(1);
                  }, onDoubleTap: () {})),
                  SizedBox(
                    width: 8,
                  ),
                ])),
          ],
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ScrollConfiguration(
                behavior: RemoveGlow(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 45 , right: 15 , left:  15 , top:  10),
                  child: PageView(
                    controller: _pageController,
                    children: [
                      // Tab 1
                      ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Job_Card('مشرف ذو خبرة في مجال التعدين '),
                          Job_Card('سائق قلابات خبرة 8 سنوات'),
                          Job_Card('مهندس جيلوجيا مع ماجستير'),
                        ],
                      ),
                      // Tab 2
                      ListView(
                        shrinkWrap: false,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Job_Card(' خريج تقنية وباحث عن عمل '),
                          Job_Card(' سائق قلابات مع رخصة معدات ثقيلة '),
                          Job_Card(' مدير فني  '),
                          Job_Card(' اريد اكتساب خبرة في الكول سنتر '),
                          Job_Card(' اريد اكتساب خبرة في الكول سنتر '),
                          Job_Card(' اريد اكتساب خبرة في الكول سنتر '),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AddNewAdds(),
            ],
          ),
        ),
      ),
    );
  }

  InkWell Job_Card(String title) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.jobsDetailes);
      },
      child: Container(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Material(
              color: Colors.transparent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),

                                  child:  CachedNetworkImage(
                                    imageUrl:  "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F1-%20%D8%A7%D9%84%D9%88%D8%B8%D8%A7%D8%A6%D9%81%20%D8%A7%D9%84%D8%A5%D8%AF%D8%A7%D8%B1%D9%8A%D8%A9.jpeg.jpg?alt=media&token=d7161e85-d563-40ec-bbfb-de5a4a390426",
                                    width:100,
                                    height: 190,
                                    fit: BoxFit.cover,
                                  )),
                              Container(
                                child: Align(
                                  child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: context.color.secondaryColor,
                                          shape: BoxShape.circle,
                                          boxShadow: context
                                                      .watch<AppThemeCubit>()
                                                      .state
                                                      .appTheme ==
                                                  AppTheme.dark
                                              ? null
                                              : [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        12, 0, 0, 0),
                                                    offset: Offset(0, 2),
                                                    blurRadius: 10,
                                                    spreadRadius: 4,
                                                  )
                                                ],
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.none,
                                          child: UiUtils.getSvg(
                                            AppIcons.like,
                                            width: 22,
                                            height: 22,
                                            color: context.color.mainBrown,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ]),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(3, 0, 3, 6),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        context.color.mainGold,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 10, 0),
                                                    child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            color: Colors.black,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'منذ 10 دقائق',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),

                                      // The Name
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15),
                                            border: Border.all(
                                                color: Colors.grey, width: 1)),
                                        child: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15),
                                            border: Border.all(
                                                color: Colors.grey, width: 1)),
                                        child: Text(
                                          'ثانوية عامة',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              fontFamily: 'Manrope'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 5),
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(15),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1)),
                                              child: Text(
                                                'شركة إيكوبيشن',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 5),
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(15),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1)),
                                              child: Text(
                                                'دوام كامل',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12,
                                                    fontFamily: 'Manrope'),
                                                maxLines: 1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: context.color.mainGold,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 5, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(' قابل للتفاوض ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: context.color.mainGold,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 5, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                      'تفاصــــــــــــيل اكــــــــــــــثر ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

Widget customJobTab(
  BuildContext context, {
  required bool isSelected,
  required String name,
  required Function() onTap,
  required Function() onDoubleTap,
}) {
  return GestureDetector(
    onTap: onTap,
    onDoubleTap: onDoubleTap,
    child: Container(
      constraints: const BoxConstraints(),
      height: 50,
      decoration: BoxDecoration(
          color: (isSelected ? (context.color.mainGold) : Colors.white),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.black,
            width: isSelected ? 1 : 1,
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
            name,
            color: isSelected ? Colors.black : context.color.textColorDark,
            fontSize: context.font.large,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    ),
  );
}
