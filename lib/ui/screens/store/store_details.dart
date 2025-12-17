import 'package:cached_network_image/cached_network_image.dart';
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class StoreDetailss extends StatelessWidget {
  const StoreDetailss({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // عدد التابات (يمكن تغييره)
      child: Scaffold(
        backgroundColor: context.color.mainColor,
        body: Column(
          children: [
            // الجزء العلوي
            Container(
              height: 300,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CachedNetworkImage(
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: storeDetailsCard(),
                  ),
                ],
              ),
            ),

            // Area containing Tabs + Content
            Expanded(
              child: Column(
                children: [
                  // Row with Tabs + Share button
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: context.color.mainGold,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                customTab("الخدمات"),
                                customTab("عن"),
                              ],
                            ),
                          ),

                          // Share Button
                          IconButton(
                            onPressed: () {
                              // action share
                            },
                            icon: Icon(Icons.share,
                                color: context.color.mainGold),
                          )
                        ],
                      ),
                    ),
                  ),

                  // محتوى التابات
                  Expanded(
                    child: TabBarView(
                      children: [
                        // TAB 1
                        DetailsTabWidget(),

                        // TAB 2
                        CommentsTabWidget(),

                        // // TAB 3
                        // ProductsTabWidget(),
                      ],
                    ),
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

// ---------------- CUSTOM TAB ----------------

Widget customTab(String title) {
  return Tab(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// ---------------- TAB CONTENT WIDGETS ----------------

// تفاصيل
class DetailsTabWidget extends StatelessWidget {
  List<String> titleList = [' تأجير مكنة تخريم  ' , '  تاجير دوزرات '  , 'تاجير قلابات'];
  List<String> detailsList = ['   لاعمال النسف ' , 'دوزرات تعمل علي مدار ال 24 ساعة '  , 'توفير قلابات مع او بدون سائقين '];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routes.storeServiceDetails);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                ),
            child: Row(
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: context.color.mainGold,
                        width: 1,
                      )),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:
                          CachedNetworkImage(
                            imageUrl: "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%85%D9%83%D9%86%D8%A9%20%D8%AA%D8%AE%D8%B1%D9%8A%D9%85.jpg?alt=media&token=558abe84-2186-44bd-a0f1-d1e73e40b3ab",
                            width: 110,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 35,
                      //   alignment: Alignment.center,
                      //   child: Text(' يضيف '),
                      // )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 10, top: 0 , left: 10),
                    height: 170,
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: double.infinity,
                          alignment: Alignment.topLeft,
                          child: Container(
                            alignment: Alignment.center,
                            width: 85,
                            color: Color(0xff9e9b9b),
                            child: Text(
                              'يحفظ 0% ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )
                          ),
                          child: Text(
                            titleList[index],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )
                          ),
                          child: Text(
                            detailsList[index],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: context.color.mainGold,
                                size: 20,
                              ),
                              Text(
                                ' 2 شخص ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.timer_outlined,
                                color: context.color.mainGold,
                                size: 20,
                              ),
                              Text(
                                '  5 ساعات ',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )
                          ),
                          child: Text(
                            ' 100 \$ ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}

// تعليقات
class CommentsTabWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: context.color.mainColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    width: double.infinity
                    ,child: Text(" عن المعلن :  " ,
                      style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),),
                  ),
                  SizedBox(height: 5,),
                  Text( """شركة إكوبيشن للاستثمار المحدودة، تأسست في عام 2021م كشركة سودانية واعدة في مجال خدمات التعدين، حيث تقدم مجموعة شاملة ومتكاملة من الخدمات في هذا القطاع، بدأت الشركة رحلتها بتأجير وتشغيل المعدات والآليات الثقيلة، وسرعان ما تمكنت من توسيع نطاق عملها لتشمل مقاولات التعدين وتأسيس وإدارة وتشغيل المناجم في المشاريع التعدينية، وتعتبر إكوبيشن من الشركات القليلة التي تقدم خدمات النقل ضمن نطاق أعمالها، وخاصة للمسافات البعيدة، وتتميز بجودة عالية وكفاءة في تقديم هذه الخدمات. بجانب ذلك، تقدم خدمات الصيانة للمعدات والآليات الثقيلة، حيث تضمن الحفاظ على أعلى مستويات الأداء والاستدامة لأصول الشركة وأصول عملائها، كما تعتمد على فريق عمل متخصص ومدرَّب بشكلٍ متطور، وتهدف دائمًا إلى توفير الموارد البشرية المتخصصة التي تلبي متطلبات الإنتاج والصناعة وتحقق أهداف العملاء بكفاءة عالية، بالإضافة إلى ذلك، تقدم الشركة خدمات توفير وتركيب ومتابعة أنظمة التتبع، وهو جانب أساسي يساهم في تعزيز كفاءة عمليات الإنتاج وضمان التحكم والأمان في المشاريع.
                  """),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    width: double.infinity
                    ,child: Text(" اوقات العمل :  " ,
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),),
                  ),
                  SizedBox(height: 5,),
                  Text("""السبت من   8 الي 4 
السبت   من 8 الي 4 
الاحد      من 8 الي 4 
الاثنين    من 8 الي 4 
الاربعاء   من 8 الي 4 
الخميس من 8 الي 4 
                   """,
                  textAlign: TextAlign.start,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    width: double.infinity
                    ,child: Text(" التواصل  :  " ,
                    style:TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),),
                  ),
                  SizedBox(height: 5,),
                  Text("""  عنواننـا : الخرطوم - عطبرة - بورتسودان \n البريد الإلكتروني الرسمي \n\ info@equipation.sd  \n   رقم الهاتف 2499-12322-447 """),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// منتجات
// class ProductsTabWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 20,
//       itemBuilder: (context, index) => Container(
//         margin: EdgeInsets.all(10),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text("منتج رقم ${index + 1}"),
//       ),
//     );
//   }
// }

class storeDetailsCard extends StatelessWidget {
  const storeDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.storedetailss);
      },
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
                width: 80,
                height: 70,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 15),
                height: 80,
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " إيكوبيشن للمعدات الثقيلة ",
                      style: TextStyle(
                          color: context.color.mainBrown,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "الخدمات 3",
                      style: TextStyle(
                          color: context.color.mainBrown,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(Icons.share_location),
                        SizedBox(
                          width: 7,
                        ),
                        Text('Km 2877')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 70,
              height: 80,
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.bookmark_border,
                color: context.color.mainGold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
