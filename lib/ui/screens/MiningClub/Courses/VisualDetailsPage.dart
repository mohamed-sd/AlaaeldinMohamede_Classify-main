import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class VisualDetailsPage extends StatelessWidget {
  const VisualDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation:3 ,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text("4.7",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        Text("183 مراجعة"),
                      ],
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: LinearProgressIndicator(value: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
    Card(
    shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15)),
    elevation:3 , child: Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.color.mainGold,
              borderRadius: BorderRadius.circular(10)
            )
            ,child: Text(
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
    )
    ),

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
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(date,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),),
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
