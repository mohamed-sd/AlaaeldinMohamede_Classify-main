import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MoneyExchange extends StatelessWidget {
  const MoneyExchange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بورصة العملات',style: TextStyle(color: context.color.mainGold),),
        backgroundColor: context.color.mainBrown,
      ),
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10 ),
            child: Material(
              color: Colors.transparent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric( vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Table Title
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF221400),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 0,
                                  color: Colors.white,
                                  offset: Offset(
                                    0,
                                    1,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(15, 3, 15, 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('اسعار الجنية',
                                                style: TextStyle(
                                                  color: Color(0xFFFEFFFF),
                                                  fontSize: 17,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                )),
                                          ]),
                                    ),
                                    Expanded(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('اليوم',
                                                style: TextStyle(
                                                  color: Color(0xFFFEFFFF),
                                                  fontSize: 17,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w800,
                                                )),
                                          ]),
                                    ),
                                  ],
                                )),
                          )),
                      // Table Body
                      material_row(context , 'جنيه سوداني / دولار امريكي' , '10:40' , '51372' , '0.90%' ),
                      rounded_material_row(context , 'جنيه سوداني / جنية مصري ' , '10:40' , '51372.4' , '0.90%' ),
                      material_row(context , 'جنيه سوداني / ريال سعودي  ' , '10:40' , '37873' , '0.90%' ),
                      rounded_material_row(context , 'جنيه سوداني / ريال قطري ' , '10:40' , '65765' , '0.90%' ),
                      material_row(context , 'جنيه سوداني / ريال عماني ' , '10:40' , '65757' , '0.90%' ),
                      rounded_material_row(context , 'جنيه سوداني / جنية استرليني  ' , '10:40' , '67575' , '0.90%' ),
                      material_row(context , 'جنيه سوداني /  ليرة تركية ' , '10:40' , '6576576' , '0.90%' ),
                      rounded_material_row(context , 'جنيه سوداني / يورو ' , '10:40' , '68768' , '0.90%' ),
                      material_row(context , 'درهم اماراتي ' , '10:40' , '786868' , '0.90%' ),
                      rounded_material_row(context , 'جنيه سوداني / دينار كويتي ' , '10:40' , '87676' , '0.90%' ),
                      material_row(context , 'جنيه سوداني / دينار بحريني ' , '10:40' , '75757' , '0.90%' ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

  Padding material_row(BuildContext context , String name , String time , String Value , String persent ) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style:
                          TextStyle(
                            fontSize: 13,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Color(0xFF73B589),
                                size: 16,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                  time,
                                  style: TextStyle(
                                    color: Color(0xFF73B589),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            ]
                        ),
                      ]
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '',
                                  style: TextStyle(
                                    color: Color(0xFF73B589),
                                    fontSize: 13,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                  )
                              ),
                              TextSpan(
                                text: Value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.arrow_circle_up,
                                color: Color(0xFF73B589),
                                size: 24,
                              ),
                              Text(
                                  persent,
                                  style:
                                  TextStyle(
                                    color: Color(0xFF73B589),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                            ]
                        ),
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }

  Container rounded_material_row(BuildContext context , String name , String time , String Value , String persent ) {
    return Container(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        child: Container(
          padding:  EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(width: 1 , color: Colors.grey),
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style:
                            TextStyle(
                              fontSize: 13,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Color(0xFFDD1F36),
                                  size: 16,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                    time,
                                    style: TextStyle(
                                      color: Color(0xFFDD1F36),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                              ]
                          ),
                        ]
                    ),
                  ),
                  Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      color: Color(0xFFDD1F36),
                                      fontSize: 13,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w800,
                                    )
                                ),
                                TextSpan(
                                  text: Value,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_circle_down,
                                  color: Color(0xFFDD1F36),
                                  size: 24,
                                ),
                                Text(
                                    persent,
                                    style:
                                    TextStyle(
                                      color: Color(0xFFDD1F36),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    )
                                ),
                              ]
                          ),
                        ]
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }

}
