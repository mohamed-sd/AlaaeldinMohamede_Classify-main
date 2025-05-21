// custom_drawer_widget.dart
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/app_icon.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/hive_utils.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart'; // حسب استخدامك
import 'package:eClassify/ui/screens/widgets/blurred_dialoge_box.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-1, 0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.65,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(0),
          ),
          shape: BoxShape.rectangle,
        ),
        alignment: AlignmentDirectional(-1, 0),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 74, 41, 14),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(100),
              topRight: Radius.circular(0),
            ),
            shape: BoxShape.rectangle,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 30),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Close Drawer Butoom
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: context.color.mainGold, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.close_rounded,
                              color: context.color.mainGold,
                            ),
                          )

                          // Button(
                          //   borderColor: context.color.mainGold,
                          //   borderRadius: 20,
                          //   borderWidth: 2,
                          //   buttonSize: 40,
                          //   icon: Icon(
                          //     Icons.close_sharp,
                          //     color: context.color.mainColor,
                          //     size: 24,
                          //   ),
                          //   onPressed: () async {
                          //
                          //   },
                          // ),
                          ),
                    ),
                  ),
                  // user Image And User Name
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {},
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: context.color.mainGold,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: 70,
                              height: 70,
                                clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.circular(18)
                              ),
                                child: CircleAvatar(
                                  radius: 18,
                                child: Image.asset('assets/profile.jpg')
                                ),
                              )
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: context.color.mainGold,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 8, 5, 8),
                                        child:
                                        HiveUtils.isUserAuthenticated() ?
                                        CustomText(
                                          HiveUtils.getUserDetails().name ?? '',
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          fontSize: context.font.large,
                                          fontWeight: FontWeight.w700,
                                        )
                                        //  Text(
                                        //    HiveUtils.getUserDetails().name ? '',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.w800),
                                        // )
                                            : Text(
                                          "مجهول",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800),
                                        ) ,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Space
                  SizedBox(
                    height: 10,
                  ),
                  //The Email Place
                  Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                            child:
                            HiveUtils.isUserAuthenticated() ?
                            CustomText(
                              HiveUtils.getUserDetails().email ?? '',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              color: Colors.white,
                              fontSize: context.font.small,
                            )
                             : Text("سجل الدخول اولا",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  // Fast Arrive Title
                  DrawerTitle(context , 'الوصـــول السريع'),
                  // Fast Arrive Links
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Links :
                      DrawerLinkOne(context , 'الرئيســــــــــية'),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, Routes.mining_exchange);
                        }
                      , child: DrawerLinkOne(context , 'بورصة المعادن')),
                      InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, Routes.mony_exchange);
                            },
                          child: DrawerLinkOne(context , 'بورصة العملات')),
                      DrawerLinkOne(context , 'اخبـــار التعدين'),
                      DrawerLinkOne(context , 'إعلانات الجهات والشركات'),
                    ],
                  ),

                  DrawerTitle(context , 'الأقســـام المميزة'),
                  // Fast Arrive Links
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Links :
                      DrawerLinkTow(context , 'استكشاف الباقات' , Icons.saved_search),
                      DrawerLinkTow(context , 'من نحن' , Icons.person),
                      DrawerLinkTow(context , 'الشروط والأحكام',Icons.privacy_tip),
                      DrawerLinkTow(context , 'الافكار والمقترحات',Icons.lightbulb),
                      DrawerLinkTow(context , 'الشكاوى والملاحظات',Icons.notifications),
                      DrawerLinkTow(context , 'التواصل عبر الواتساب',Icons.message),
                    ],
                  ),

                  // LogOut Buttom
                  HiveUtils.isUserAuthenticated() ?
                  InkWell(
                    onTap: (){
                      // logOutConfirmWidget();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.color.mainGold,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 10, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 0),
                                        child: Icon(
                                          Icons.logout,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              5, 8, 5, 8),
                                          child: Text(
                                            'تسجيل خروج',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding DrawerLinkOne(BuildContext context , String title) {
    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                      child: InkWell(
                        onTap: () async {},
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.keyboard_double_arrow_left,
                              color: context.color.mainGold,
                              size: 24,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Divider(
                                      thickness: 1,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
  }

  Padding DrawerLinkTow(BuildContext context , String title , IconData icon) {
    return // Generated code for this Container Widget...
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
        child: InkWell(
          onTap: () {
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Icon(
                      icon,
                      color: context.color.mainGold,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Text(
                      title,
                      style:
                      TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ;
  }

  Padding DrawerTitle(BuildContext context , String title) {
    return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.color.mainGold,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5, 8, 5, 8),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 20,
                            ),
                          ]),
                    ),
                  ),
                );
  }

}


