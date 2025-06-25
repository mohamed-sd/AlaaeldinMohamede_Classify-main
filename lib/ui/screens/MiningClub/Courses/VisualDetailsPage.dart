import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VisualDetailsPage extends StatelessWidget {
  const VisualDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color goldColor = context.color.mainGold;
    Color star = Color.fromARGB(255, 227, 223, 223);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.mainBrown,
      ),
      backgroundColor: context.color.mainColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // صورة الفيديو
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/profile.jpg',
                            height: 200,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        const Positioned.fill(
                          child: Center(
                            child: Icon(Icons.play_circle_fill,
                                color: Colors.white, size: 64),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50, right: 10),
                    child: const Text(
                      "تشغيل الآليات مقارنة بين نموذج الإيجار والشراء",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat(Icons.remove_red_eye, "985,568"),
                        _buildStat(Icons.thumb_up, "74,468"),
                        _buildStat(Icons.comment, "15,244"),
                        _buildStat(Icons.share, "مشاركة"),
                      ],
                    ),
                  )
                ])),
            const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/profile.jpg',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("قناة الوسيط للمقاولات ونفط حقل السمنت"),
                        Text("2.1 مليون مشترك",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: context.color.mainGold,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(5),
                    child: Center(child: Text('إشتراك')),
                  ),
                ],
              ),
            ),
            // الإحصائيات
            const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/profile.jpg',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        focusColor: context.color.mainBrown,
                        hintText: 'إضافة تعليق...',
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
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
                            //***********************************************************8
                            // Padding(
                            //   padding: EdgeInsetsDirectional.fromSTEB(10, 3, 10, 3),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.max,
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: RatingBar.builder(
                            //           onRatingUpdate: (newValue) => safeSetState(
                            //                   () => _model.ratingBarValue3 = newValue),
                            //           itemBuilder: (context, index) => Icon(
                            //             FFIcons.kstore1,
                            //             color: FlutterFlowTheme.of(context).buttonApp,
                            //           ),
                            //           direction: Axis.horizontal,
                            //           initialRating: _model.ratingBarValue3 ??= 4,
                            //           unratedColor:
                            //           FlutterFlowTheme.of(context).boederColor,
                            //           itemCount: 5,
                            //           itemSize: 18,
                            //           glowColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: LinearPercentIndicator(
                            //           percent: 0.8,
                            //           width: MediaQuery.sizeOf(context).width * 0.25,
                            //           lineHeight: 13,
                            //           animation: true,
                            //           animateFromLastPercent: true,
                            //           progressColor:
                            //           FlutterFlowTheme.of(context).combonantbg,
                            //           backgroundColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //           barRadius: Radius.circular(5),
                            //           padding: EdgeInsets.zero,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            //         child: Text(
                            //           '%02.0',
                            //           style: FlutterFlowTheme.of(context)
                            //               .bodyMedium
                            //               .override(
                            //             fontFamily: FlutterFlowTheme.of(context)
                            //                 .bodyMediumFamily,
                            //             color: FlutterFlowTheme.of(context).black,
                            //             fontSize: 13,
                            //             letterSpacing: 0.0,
                            //             fontWeight: FontWeight.w500,
                            //             useGoogleFonts:
                            //             !FlutterFlowTheme.of(context)
                            //                 .bodyMediumIsCustom,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsetsDirectional.fromSTEB(10, 3, 10, 3),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.max,
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: RatingBar.builder(
                            //           onRatingUpdate: (newValue) => safeSetState(
                            //                   () => _model.ratingBarValue4 = newValue),
                            //           itemBuilder: (context, index) => Icon(
                            //             FFIcons.kstore1,
                            //             color: FlutterFlowTheme.of(context).buttonApp,
                            //           ),
                            //           direction: Axis.horizontal,
                            //           initialRating: _model.ratingBarValue4 ??= 3,
                            //           unratedColor:
                            //           FlutterFlowTheme.of(context).boederColor,
                            //           itemCount: 5,
                            //           itemSize: 18,
                            //           glowColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: LinearPercentIndicator(
                            //           percent: 0.6,
                            //           width: MediaQuery.sizeOf(context).width * 0.25,
                            //           lineHeight: 13,
                            //           animation: true,
                            //           animateFromLastPercent: true,
                            //           progressColor:
                            //           FlutterFlowTheme.of(context).combonantbg,
                            //           backgroundColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //           barRadius: Radius.circular(5),
                            //           padding: EdgeInsets.zero,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            //         child: Text(
                            //           '%24.5',
                            //           style: FlutterFlowTheme.of(context)
                            //               .bodyMedium
                            //               .override(
                            //             fontFamily: FlutterFlowTheme.of(context)
                            //                 .bodyMediumFamily,
                            //             color: FlutterFlowTheme.of(context).black,
                            //             fontSize: 13,
                            //             letterSpacing: 0.0,
                            //             fontWeight: FontWeight.w500,
                            //             useGoogleFonts:
                            //             !FlutterFlowTheme.of(context)
                            //                 .bodyMediumIsCustom,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsetsDirectional.fromSTEB(10, 3, 10, 3),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.max,
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: RatingBar.builder(
                            //           onRatingUpdate: (newValue) => safeSetState(
                            //                   () => _model.ratingBarValue5 = newValue),
                            //           itemBuilder: (context, index) => Icon(
                            //             FFIcons.kstore1,
                            //             color: FlutterFlowTheme.of(context).buttonApp,
                            //           ),
                            //           direction: Axis.horizontal,
                            //           initialRating: _model.ratingBarValue5 ??= 2,
                            //           unratedColor:
                            //           FlutterFlowTheme.of(context).boederColor,
                            //           itemCount: 5,
                            //           itemSize: 18,
                            //           glowColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: LinearPercentIndicator(
                            //           percent: 0.8,
                            //           width: MediaQuery.sizeOf(context).width * 0.25,
                            //           lineHeight: 13,
                            //           animation: true,
                            //           animateFromLastPercent: true,
                            //           progressColor:
                            //           FlutterFlowTheme.of(context).combonantbg,
                            //           backgroundColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //           barRadius: Radius.circular(5),
                            //           padding: EdgeInsets.zero,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            //         child: Text(
                            //           '%00.1',
                            //           style: FlutterFlowTheme.of(context)
                            //               .bodyMedium
                            //               .override(
                            //             fontFamily: FlutterFlowTheme.of(context)
                            //                 .bodyMediumFamily,
                            //             color: FlutterFlowTheme.of(context).black,
                            //             fontSize: 13,
                            //             letterSpacing: 0.0,
                            //             fontWeight: FontWeight.w500,
                            //             useGoogleFonts:
                            //             !FlutterFlowTheme.of(context)
                            //                 .bodyMediumIsCustom,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsetsDirectional.fromSTEB(10, 3, 10, 3),
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.max,
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: RatingBar.builder(
                            //           onRatingUpdate: (newValue) => safeSetState(
                            //                   () => _model.ratingBarValue6 = newValue),
                            //           itemBuilder: (context, index) => Icon(
                            //             FFIcons.kstore1,
                            //             color: FlutterFlowTheme.of(context).buttonApp,
                            //           ),
                            //           direction: Axis.horizontal,
                            //           initialRating: _model.ratingBarValue6 ??= 1,
                            //           unratedColor:
                            //           FlutterFlowTheme.of(context).boederColor,
                            //           itemCount: 5,
                            //           itemSize: 18,
                            //           glowColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                            //         child: LinearPercentIndicator(
                            //           percent: 0.9,
                            //           width: MediaQuery.sizeOf(context).width * 0.25,
                            //           lineHeight: 13,
                            //           animation: true,
                            //           animateFromLastPercent: true,
                            //           progressColor:
                            //           FlutterFlowTheme.of(context).combonantbg,
                            //           backgroundColor:
                            //           FlutterFlowTheme.of(context).buttonApp,
                            //           barRadius: Radius.circular(5),
                            //           padding: EdgeInsets.zero,
                            //         ),
                            //       ),
                            //       Padding(
                            //         padding:
                            //         EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            //         child: Text(
                            //           '%00.7',
                            //           style: FlutterFlowTheme.of(context)
                            //               .bodyMedium
                            //               .override(
                            //             fontFamily: FlutterFlowTheme.of(context)
                            //                 .bodyMediumFamily,
                            //             color: FlutterFlowTheme.of(context).black,
                            //             fontSize: 13,
                            //             letterSpacing: 0.0,
                            //             fontWeight: FontWeight.w500,
                            //             useGoogleFonts:
                            //             !FlutterFlowTheme.of(context)
                            //                 .bodyMediumIsCustom,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),

                    // Column(
                    //   children: const [
                    //     Text("4.7",
                    //         style: TextStyle(
                    //             fontSize: 32, fontWeight: FontWeight.bold)),
                    //     Text("183 مراجعة"),
                    //   ],
                    // ),
                    // const Expanded(
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 12),
                    //     child: LinearProgressIndicator(value: 0.9),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: context.color.mainGold,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "التعليقات والتقييمات",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 5),
                      _buildReview(
                        name: "علاء الدين عبدالباقي",
                        date: "2024/6/19",
                        comment:
                            "هذا المحتوى هو فعلاً مميز، أن تعديل في نفس الساحة قد تم توضيحه للناس بشكل رائع، حيث تمكنك أداة الرد هنا من الرد أو التعديل في النصوص الأخرى بإضافة إلى زيادة عدد الحروف إلخ. شكراً للتنظيم.",
                      ),
                      _buildReview(
                        name: "علاء الدين عبدالباقي",
                        date: "2024/6/19",
                        comment:
                            "هذا المحتوى هو فعلاً مميز، أن تعديل في نفس الساحة قد تم توضيحه للناس بشكل رائع، حيث تمكنك أداة الرد هنا من الرد أو التعديل في النصوص الأخرى بإضافة إلى زيادة عدد الحروف إلخ. شكراً للتنظيم.",
                      ),
                      _buildReview(
                        name: "علاء الدين عبدالباقي",
                        date: "2024/6/19",
                        comment:
                            "هذا المحتوى هو فعلاً مميز، أن تعديل في نفس الساحة قد تم توضيحه للناس بشكل رائع، حيث تمكنك أداة الرد هنا من الرد أو التعديل في النصوص الأخرى بإضافة إلى زيادة عدد الحروف إلخ. شكراً للتنظيم.",
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 232, 187, 39),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 15,
          ),
          const SizedBox(width: 6),
          Text(count,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildReview(
      {required String name, required String date, required String comment}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle, size: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(date,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Icon(Icons.more_vert)
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star_half, color: Colors.amber, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment),
        ],
      ),
    );
  }
}
