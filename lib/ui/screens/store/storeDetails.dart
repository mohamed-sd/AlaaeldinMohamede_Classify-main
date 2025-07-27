import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/screens/exchange/money_exchange.dart';
import 'package:eClassify/ui/screens/home/widgets/location_widget.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class storeDetails extends StatefulWidget {
  @override
  _storeDetailseState createState() => _storeDetailseState();
}

// const storeDetails({super.key});

class _storeDetailseState extends State<storeDetails> {
  int selectTab = 0;
  int selectedTab = 0;
  final Color goldColor = Color(0xFFEBBE25);
  Color star = Color.fromARGB(255, 227, 223, 223);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.color.mainColor,
        appBar: AppBar(
          backgroundColor: context.color.mainBrown,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.color.mainBrown,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  ' متجر المعلن ',
                  style: TextStyle(
                      color: context.color.mainGold,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 5, left: 5),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: UiUtils.imageType(
                                'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                                width: 50.0,
                                height: 50.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 1),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 2, 5, 2),
                                              child: Text(
                                                  'شركة عبد الرحمن آل جاسم',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 1, 5, 5),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 2, 5, 2),
                                              child: Text(
                                                  'الشركة الاعلي تقييما في آليات الحفر',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Material(
                          color: Colors.transparent,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: context
                                                            .color.mainGold,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: List.generate(5,
                                                          (index) {
                                                        num _rating = 4;
                                                        return GestureDetector(
                                                          onTap: () {
                                                            // setState(() {
                                                            //   _rating = index + 1;
                                                            // });
                                                          },
                                                          child: Icon(
                                                            index < _rating
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border,
                                                            color: Colors.amber,
                                                            size: 20,
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .color.mainGold,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            5,
                                                                            5,
                                                                            0),
                                                                child: Text(
                                                                    '4.7',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            2,
                                                                            0,
                                                                            2,
                                                                            5),
                                                                child: Text(
                                                                    ' تقييم ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .color.mainGold,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            5,
                                                                            5,
                                                                            0),
                                                                child: Text(
                                                                    '1.2K',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            2,
                                                                            0,
                                                                            2,
                                                                            5),
                                                                child: Text(
                                                                    ' المتابعين ',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .color.mainGold,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            5,
                                                                            5,
                                                                            0),
                                                                child: Text(
                                                                    '120K',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            2,
                                                                            0,
                                                                            2,
                                                                            5),
                                                                child: Text(
                                                                    'تم البيع',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(3),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: context
                                                            .color.mainGold,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            5,
                                                                            5,
                                                                            0),
                                                                child: Text(
                                                                    '175',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            2,
                                                                            0,
                                                                            2,
                                                                            5),
                                                                child: Text(
                                                                    'إعلان',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: context.color.mainGold,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 5, 5, 5),
                                                    child: Text('متابعة',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  )))))),
              SizedBox(
                height: 10,
              ),

              // الأزرار (التابات)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton(' الاعلانات ', 0),
                  SizedBox(width: 8),
                  _buildTabButton(' ملف المعلن ', 1),
                  SizedBox(width: 8),
                  _buildTabButton(' التقييمات ', 2),
                ],
              ),

              SizedBox(height: 10),

              // المحتوى الخاص بكل تاب
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: _buildTabContent(),
                ),
              ),

              // Expanded(
              //     child: TabBarView(
              //       children: [
              //         Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               color: Colors.red,
              //               borderRadius: BorderRadius.circular(0),
              //             ),
              //             child: Padding(
              //                 padding: EdgeInsets.all(5),
              //                 child: Column(
              //                     mainAxisSize: MainAxisSize.max,
              //                     children: [
              //                       Flexible(child: Column(children: [
              //
              //                       ]))
              //                     ]))),
              //         Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               color: Colors.red,
              //               borderRadius: BorderRadius.circular(0),
              //             ),
              //             child: Padding(
              //                 padding: EdgeInsets.all(5),
              //                 child: Column(
              //                     mainAxisSize: MainAxisSize.max,
              //                     children: [
              //                       Flexible(child: Column(children: [
              //
              //                       ]))
              //                     ]))),
              //         Container(
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               color: Colors.red,
              //               borderRadius: BorderRadius.circular(0),
              //             ),
              //             child: Padding(
              //                 padding: EdgeInsets.all(5),
              //                 child: Column(
              //                     mainAxisSize: MainAxisSize.max,
              //                     children: [
              //                       Flexible(child: Column(children: [
              //
              //                       ]))
              //                     ]))),
              //       ],
              //     ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 110,
        ),
        height: 50,
        decoration: BoxDecoration(
            color: (isSelected ? (context.color.mainGold) : Colors.grey),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.transparent,
              width: isSelected ? 1 : 1,
            ),
            borderRadius: BorderRadius.circular(11)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              title,
              color: isSelected ? Colors.black : context.color.textColorDark,
              fontSize: context.font.large,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedTab = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(title),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return Container(
            child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, -1),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: context.color.mainGold,
                                          width: 3,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: context.color.mainGold,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 1, 5, 1),
                                          child: Text('اكثر مبيعا',
                                              style: TextStyle(
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, -1),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: context.color.mainGold,
                                          width: 3,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: context.color.mainGold,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 1, 5, 1),
                                          child: Text(' لودرات ',
                                              style: TextStyle(
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, -1),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: context.color.mainGold,
                                          width: 3,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: context.color.mainGold,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 1, 5, 1),
                                          child: Text(' سطحات ',
                                              style: TextStyle(
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, -1),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: context.color.mainGold,
                                          width: 3,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: context.color.mainGold,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 1, 5, 1),
                                          child: Text(' قلابات ',
                                              style: TextStyle(
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: Container(
                              width: 70,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, -1),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: context.color.mainGold,
                                          width: 3,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: context.color.mainGold,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 1, 5, 1),
                                          child: Text(' اخرى ',
                                              style: TextStyle(
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
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
                  ),
                ),
              ],
            ),
          ],
        ));
      case 1:
        return Container(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
              child: Material(
                color: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: UiUtils.imageType(
                              'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 1),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 2, 5, 2),
                                          child: Text('شركة عبد الرحمن آل جاسم',
                                              style: TextStyle(
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 1, 5, 5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 2, 5, 2),
                                          child: Text('شركة آليات',
                                              style: TextStyle(
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 1, 5, 5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 2, 5, 2),
                                          child: Text('09379737983',
                                              style: TextStyle(
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 1, 5, 5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 2, 5, 2),
                                          child: Text('info@algasin.com',
                                              style: TextStyle(
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 1, 5, 5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 2, 5, 2),
                                          child: Text('الخرطوم - بحري ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
              child: Material(
                color: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 3, 5, 1),
                          child: Container(
                            width: double.infinity,
                            height: 30,
                            decoration: BoxDecoration(
                              color: context.color.mainGold,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                      child: Text('الوصف التعريفي',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                              'هذا النص هو مثال لنص يمكن ان يستبدل بنفس المساحة لقد تم توليد هذا النص من مولد النص العربي حيث يمكن ان تولد مثل هذا النص او العديد من النصوص الاخرى إضافة الي زيادة عدد الحروف التي يولدها التطبيق',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ],
                                  ),
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
          ],
        ));
      case 2:
        return Container(
            child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: context.color.mainGold,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Text(
                              '4.7 تقييم و 183 مراجعة ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
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
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%87.5',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
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
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%02.0',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
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
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%24.7',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
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
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%08.0',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
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
                                  Padding(
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
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%18.5',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                ],
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
          ],
        ));
      default:
        return Container();
    }
  }
}
