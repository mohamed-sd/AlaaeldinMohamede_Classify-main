import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StoreServiceDetails extends StatelessWidget {
  const StoreServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Color goldColor = Colors.red;
    Color star = Colors.yellow;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: context.color.mainBrown,
        title: Text(
          " تفاصيل الخدمة ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        elevation: 0,
      ),
      backgroundColor: context.color.mainColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Head Ditails
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
                        width: 100,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " تاجير قلابات ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [Icon(Icons.person), Text('شخص 1 ')],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [Icon(Icons.alarm), Text('ساعة 1 ')],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(Icons.star),
                              Text('5.0'),
                              Divider(),
                              Text('3 مراجعين'),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("180.00 \$"),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // About Service
              Text(
                "عن الخدمة",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                  'تاجير افضل القلابات  وتوفير افضل الموديلات مع توفير خدمات مميزة مثل خدمات الصيانة والدعم الفني وتوفير سائقين مع خبرة تفوق ال 5 سنين '),
              SizedBox(
                height: 20,
              ),
              // Rating and reviews
              Text(
                " التقييم والخدمات ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.storedetails);
                },
                child: Icon(Icons.add_box),
              ),
              // Rating Container
              Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFC1BBBB),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('5.0', style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 20),
                                    Icon(Icons.star, color: star, size: 20),
                                    Icon(Icons.star, color: star, size: 20),
                                    Icon(Icons.star, color: star, size: 20),
                                    Icon(Icons.star, color: star, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('5'),SizedBox(width: 5,),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                        child: LinearPercentIndicator(
                                          percent: 0.87,
                                          width: MediaQuery.of(context).size.width *
                                              0.25,
                                          lineHeight: 13,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor: context.color
                                              .mainGold, // اختر لون مناسب للتقدم
                                          backgroundColor:
                                          Color(0xFFE0E0E0), // لون الخلفية
                                          barRadius: Radius.circular(5),
                                          padding: EdgeInsets.zero,
                                          isRTL: true,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        child: Text('%87.5',
                                            style: TextStyle(
                                              fontSize: 13,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ))),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('4'),SizedBox(width: 5,),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                        child: LinearPercentIndicator(
                                          percent: 0.02,
                                          width: MediaQuery.of(context).size.width *
                                              0.25,
                                          lineHeight: 13,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor: context.color
                                              .mainGold, // اختر لون مناسب للتقدم
                                          backgroundColor:
                                          Color(0xFFE0E0E0), // لون الخلفية
                                          barRadius: Radius.circular(5),
                                          padding: EdgeInsets.zero,
                                          isRTL: true,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        child: Text('%02.0',
                                            style: TextStyle(
                                              fontSize: 13,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ))),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('3'),SizedBox(width: 5,),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                        child: LinearPercentIndicator(
                                          percent: 0.24,
                                          width: MediaQuery.of(context).size.width *
                                              0.25,
                                          lineHeight: 13,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor: context.color
                                              .mainGold, // اختر لون مناسب للتقدم
                                          backgroundColor:
                                          Color(0xFFE0E0E0), // لون الخلفية
                                          barRadius: Radius.circular(5),
                                          padding: EdgeInsets.zero,
                                          isRTL: true,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        child: Text('%24.7',
                                            style: TextStyle(
                                              fontSize: 13,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ))),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('2'),SizedBox(width: 5,),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                        child: LinearPercentIndicator(
                                          percent: 0.08,
                                          width: MediaQuery.of(context).size.width *
                                              0.25,
                                          lineHeight: 13,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor: context.color
                                              .mainGold, // اختر لون مناسب للتقدم
                                          backgroundColor:
                                          Color(0xFFE0E0E0), // لون الخلفية
                                          barRadius: Radius.circular(5),
                                          padding: EdgeInsets.zero,
                                          isRTL: true,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        child: Text('%08.0',
                                            style: TextStyle(
                                              fontSize: 13,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ))),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('1'),SizedBox(width: 5,),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                        child: LinearPercentIndicator(
                                          percent: 0.18,
                                          width: MediaQuery.of(context).size.width *
                                              0.25,
                                          lineHeight: 13,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor: context.color
                                              .mainGold, // اختر لون مناسب للتقدم
                                          backgroundColor:
                                          Color(0xFFE0E0E0), // لون الخلفية
                                          barRadius: Radius.circular(5),
                                          padding: EdgeInsets.zero,
                                          isRTL: true,
                                        ),
                                      ),
                                    ),

                                         Text('%18.5',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
