import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommunitiesPage extends StatelessWidget {
  final String title;
  final String flag ;
  const CommunitiesPage({super.key, required this.title, required this.flag});

  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments as Map<String, String>;

    return MaterialPageRoute(
      builder: (_) => CommunitiesPage(
        title: args['title'] ?? '',
        flag: args['flag'] ?? '',
      ),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: context.color.mainBrown,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          NewsCard(
            title: "افتتاح مبادرة بيئية جديدة",
            imageUrl: "https://images.unsplash.com/photo-1580128660010-fd027e1e587a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHx0cnVtcHxlbnwwfHx8fDE3MzM0MDMxNTJ8MA&ixlib=rb-4.0.3&q=80&w=1080",
            date: DateTime(2025, 6, 25),
            category: "بيئة",
            summary: "تم إطلاق مبادرة تهدف إلى تنظيف الأحياء وتعزيز الوعي البيئي بين المواطنين.",
            likes: 120,
            comments: 45,
            views: 980,
          ),
          NewsCard(
            title: "فعالية تطوعية في حي النصر",
            imageUrl: "https://images.unsplash.com/photo-1580128660010-fd027e1e587a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHx0cnVtcHxlbnwwfHx8fDE3MzM0MDMxNTJ8MA&ixlib=rb-4.0.3&q=80&w=1080",
            date: DateTime(2025, 6, 24),
            category: "تطوع",
            summary: "شارك أكثر من 100 متطوع في فعالية تنظيف الحدائق العامة في حي النصر.",
            likes: 80,
            comments: 20,
            views: 430,
          ),
          NewsCard(
            title: "انطلاق حملة للتبرع بالدم",
            imageUrl: "https://images.unsplash.com/photo-1580128660010-fd027e1e587a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHx0cnVtcHxlbnwwfHx8fDE3MzM0MDMxNTJ8MA&ixlib=rb-4.0.3&q=80&w=1080",
            date: DateTime(2025, 6, 20),
            category: "صحة",
            summary: "بدأت الحملة بالتعاون مع المستشفى الوطني وتهدف لتوفير الدم للمحتاجين.",
            likes: 230,
            comments: 65,
            views: 1500,
          ),
        ],
      ),
    );
  }
}

// كارد الخبر القابل لإعادة الاستخدام
class NewsCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final DateTime date;
  final String category;
  final String summary;
  final int likes;
  final int comments;
  final int views;

  const NewsCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.category,
    required this.summary,
    required this.likes,
    required this.comments,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: GestureDetector(
            onTap: () {

            },
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(mainAxisSize: MainAxisSize.max, children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: context.color.mainGold,
                                                    borderRadius:
                                                    BorderRadius.circular(7),
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          10, 3, 10, 3),
                                                      child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              category,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                              ),
                                                            ),
                                                          ])))),
                                          Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: context.color.mainGold,
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                    ),
                                                    child: Padding(
                                                        padding: EdgeInsetsDirectional
                                                            .fromSTEB(10, 3, 10, 3),
                                                        child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                AlignmentDirectional(
                                                                    1, 0),
                                                                child: Text(
                                                                  date.toString(),
                                                                  textAlign:
                                                                  TextAlign.start,
                                                                  style: TextStyle(
                                                                    fontSize: 10,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ]))),
                                              )),
                                        ]),
                                    Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(title,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w800,
                                                      color: Colors.black)),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                            AlignmentDirectional(-1, 0),
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                  summary,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          ),
                                          Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          color: context
                                                              .color.mainGold,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10,
                                                                3, 10, 3),
                                                            child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                children: [
                                                                  Text(
                                                                    likes.toString(),
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      10,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15,
                                                                  ),
                                                                ])))),
                                                Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          color: context
                                                              .color.mainGold,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10,
                                                                3, 10, 3),
                                                            child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                children: [
                                                                  Text(
                                                                    comments.toString(),
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      10,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Icon(
                                                                    Icons.message,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15,
                                                                  ),
                                                                ])))),
                                                Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          color: context
                                                              .color.mainGold,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10,
                                                                3, 10, 3),
                                                            child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                children: [
                                                                  Text(
                                                                    views.toString(),
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      10,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .remove_red_eye,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 15,
                                                                  ),
                                                                ])))),
                                              ]),
                                        ]),
                                  ]),
                            ),
                          ),
                        ]),
                      ],
                    ))),
          ));
  }

  Widget _iconWithText(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(count.toString(), style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
