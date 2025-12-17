import 'package:cached_network_image/cached_network_image.dart';
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ProvideStore extends StatelessWidget {
  const ProvideStore({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: context.color.mainBrown,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
              alignment: Alignment.center,
              height: 10,
              margin: EdgeInsets.only(right: 15, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
              )),
        ),
        title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'متجر إيكوبيشن',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )),
                Icon(Icons.filter_list),
              ],
            )),
        elevation: 0,
      ),
      backgroundColor: context.color.mainColor,
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return storeDetailsCard();
        },
      ),
    );
  }
}

class storeDetailsCard extends StatelessWidget {
  const storeDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
              child: CachedNetworkImage(
               imageUrl:"https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Bareeq%2F%D9%88%D8%B2%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86%20(1).jpg?alt=media&token=f66650db-36a5-4924-b56f-ac526402990e",
                width: 80,
                height: 80,
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
                      "إكوبيشن للمعدات الثقيلة",
                      style: TextStyle(
                          color: context.color.mainBrown,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
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
                    SizedBox(
                      height: 5,
                    ),
                    Text("3 خدمة" , style: TextStyle(
                      color: Colors.grey
                    ),),
                  ],
                ),
              ),
            ),
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.bottomLeft,
              child: Icon(
                Icons.bookmark_border,
                color: context.color.mainBrown,
              ),
            )
          ],
        ),
      ),
    );
  }
}
