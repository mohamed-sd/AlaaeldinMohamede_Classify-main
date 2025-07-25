import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class VisualMaterialsPage extends StatelessWidget {
  const VisualMaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: AppBar(
        backgroundColor: context.color.mainBrown,
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.arrow_forward),
          )
        ],
        leading: const Icon(Icons.settings),
      ),
      body: Column(
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
              'الفيديوهات التوعوية',
              style: TextStyle(
                  color: context.color.mainGold,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: 6, // عدد الفيديوهات
              itemBuilder: (context, index) {
                return VideoCard(
                  title: index.isEven
                      ? "تشغيل الآليات مقارنة بين نموذج الإيجار والشراء"
                      : "كيفية السماد    ",
                  channel: index.isEven
                      ? "قناة نبات لخدمات الزراعة"
                      : "قناة شركة رابح المحدودة لخدمات الزراعة",
                  duration: index.isEven ? "55:47" : "34:27",
                  views: index.isEven ? "348 ألف" : "975 ألف",
                  daysAgo: "منذ 7 أيام",
                );
              },
            ),

          ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10 , left: 10),
            padding: EdgeInsets.all(5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.color.mainGold,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text("المزيد", textAlign: TextAlign.center,
                style: TextStyle( fontSize: 20,
                    color: Colors.black, fontWeight: FontWeight.w800)),
          ),
          SizedBox(height: 20,)
        ],
      ),


          // Container(
          //   margin: EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10)
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 10),
          //     child: ElevatedButton(
          //       onPressed: () {},
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: context.color.mainGold,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //       child: Container(
          //         width: double.infinity,
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          //           child: Text("المزيد",
          //               style: TextStyle(
          //                   color: Colors.black, fontWeight: FontWeight.bold)),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String title;
  final String channel;
  final String duration;
  final String views;
  final String daysAgo;

  const VideoCard({
    super.key,
    required this.title,
    required this.channel,
    required this.duration,
    required this.views,
    required this.daysAgo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.visualDetailsPage);

      },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          decoration: BoxDecoration(
                              color: context.color.mainGold,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 5, right: 5, left: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(channel,
                                style: const TextStyle(fontSize: 11, color: Colors.black)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, right: 5, left: 5),
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey, width: 1)),
                                  child: Text("$views مشاهدة  ",
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.black))),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey, width: 1)),
                                    child: Text("$daysAgo",
                                        style: const TextStyle(
                                            fontSize: 11, color: Colors.black))),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5 , right: 5 , left: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.color.mainGold,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                        'تفاصــــــــــــيل اكــــــــــــــثر ',
                                        textAlign: TextAlign.center,
                                        style:
                                        TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: context.color.mainGold , borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/login.jpg',
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned.fill(
                          child: Center(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.play_arrow, color: Colors.red),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            child: Text(
                              duration,
                              style:
                              const TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        )
    );
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.visualDetailsPage);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    // borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      'assets/profile.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Positioned.fill(
                    child: Center(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.play_arrow, color: Colors.red),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      child: Text(
                        duration,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              decoration: BoxDecoration(
                  color: context.color.mainGold,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, right: 5, left: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(channel,
                    style: const TextStyle(fontSize: 11, color: Colors.black)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, right: 5, left: 5),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Text("$views مشاهدة  ",
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black))),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Text("$daysAgo",
                            style: const TextStyle(
                                fontSize: 11, color: Colors.black))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
