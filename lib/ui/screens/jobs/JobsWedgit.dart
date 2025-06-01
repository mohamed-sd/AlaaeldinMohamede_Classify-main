import 'package:eClassify/ui/screens/exchange/money_exchange.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';

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
          title: ' الوظائف ',
          showBackButton: true,
          backgroundColor: context.color.mainBrown,
          bottomHeight: 60,
          bottom: [
            SizedBox(
              height: 5,
            ),
            SizedBox(
                width: context.screenWidth,
                height: 50,
                child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsetsDirectional.fromSTEB(18, 5, 18, 2),
                    scrollDirection: Axis.horizontal,
                    children: [
                      customTab(context,
                          isSelected: (selectTab == 0),
                          name: ' عارض وظيفة ', onTap: () {
                        selectTab = 0;
                        setState(() {});
                        _pageController.jumpToPage(0);
                      }, onDoubleTap: () {}),
                      SizedBox(
                        width: 8,
                      ),
                      customTab(context,
                          isSelected: (selectTab == 1),
                          name: ' باحث عن وظيفة ', onTap: () {
                        selectTab = 1;
                        setState(() {});
                        _pageController.jumpToPage(1);
                      }, onDoubleTap: () {}),
                      SizedBox(
                        width: 8,
                      ),
                      customTab(context,
                          isSelected: (selectTab == 2),
                          name: ' باحث عن تدريب ', onTap: () {
                        selectTab = 2;
                        setState(() {});
                        _pageController.jumpToPage(2);
                      }, onDoubleTap: () {}),
                      SizedBox(
                        width: 8,
                      ),
                    ])),
          ],
        ),
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: RemoveGlow(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                controller: _pageController,
                children: [
                  // Tab 1
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Job_Card('مشرف ذو خبرة في مجال التعدين '),
                      Job_Card('سائق قلابات خبرة 8 سنوات'),
                      Job_Card('مهندس جيلوجيا مع ماجستير'),
                    ],
                  ),
                  // Tab 2
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Job_Card(' خريج تقنية وباحث عن عمل '),
                      Job_Card(' سائق قلابات مع رخصة معدات ثقيلة '),
                      Job_Card(' مدير فني  '),
                    ],
                  ),
                  // Tab 3
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Job_Card(' تدريب علي الاحصاء خريج جديد '),
                      Job_Card(' باحث عن فرصة لدي شركة تعدين '),
                      Job_Card(' اريد اكتساب خبرة في الكول سنتر '),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container Job_Card( String title ) {
    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(2, 2)
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                padding: EdgeInsets.only(right: 20 , left: 20 , top: 5),
                                child: Image.asset(
                                  'assets/profile.jpg',
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(title , style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  Row(
                                    children: [
                                      Icon(Icons.cabin_outlined , size: 13,),
                                      Text(' إيكوبيشن ' ,style: TextStyle(
                                          fontSize: 13,
                                      )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time , size: 13,),
                                      Text(' منذ 10 ', style: TextStyle(
                                        fontSize: 13,
                                      )),
                                    ],
                                  )
                                ],
                              )),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.favorite_border),
                              )
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20 , vertical: 2),
                                  decoration: BoxDecoration(
                                      color:
                                          Color.fromARGB(255, 237, 237, 237),
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              10)),
                                  child: Text('دوام كامل'),
                                ),
                                Padding(
                                  padding:EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [Text('1500 - 2500')],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
  }
}
