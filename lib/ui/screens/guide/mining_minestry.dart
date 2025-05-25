import 'package:eClassify/app/routes.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class Mining_minestry extends StatelessWidget {
  const Mining_minestry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: AppBar(
        backgroundColor: context.color.mainBrown,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView(
            children: [
              // the title
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: context.color.mainGold,
                      borderRadius: BorderRadiusDirectional.circular(15)),
                  child: Text(
                    'وزارة المعادن',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
              ),

              // Container
              Padding(
                padding: EdgeInsets.all(10),
                child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 365,
                        height: 143,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/guid.jpg',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // the title
                            the_title('تراخيص التعدين '),

                            // The Light Row
                            InkWell(
                                onTap: () {},
                                child: light_row( context , 'إجراءات رخصة البحث العامة ')),
                            InkWell(
                                onTap: () {},
                                child: Dark_row( context ,  ' إجراءات رخصة البحث المطلقة ')),
                            InkWell(
                                onTap: () {},
                                child: light_row( context , ' إجراءات رخصة الإمتياز  ')),

                            the_title(
                                'عقود التعدين وإستخراج الصخور والمعادن الصناعية'),

                            InkWell(
                                onTap: () {},
                                child: Dark_row(context ,'مطلوبات عقد التعدين الكبير ')),

                            InkWell(
                                onTap: () {},
                                child: light_row(context ,  'مطلوبات عقد التعدين الصغير ')),

                            InkWell(
                                onTap: () {},
                                child: Dark_row(context ,'مطلوبات عقد التعدين التقليدي ')),

                            InkWell(
                                onTap: () {},
                                child: light_row( context , 'مطلوبات عقد المعادن والصخور')),

                            InkWell(
                                onTap: () {},
                                child: Dark_row(context ,'مطلوبات رخصة التعامل في الأحجار الكريمة')),

                            InkWell(
                                onTap: () {},
                                child: light_row( context , 'ضوابط العمل في التعدين النهري')),

                          ],
                        ),
                      )),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.color.mainGold,
                  borderRadius: BorderRadiusDirectional.circular(18),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.link , size: 30, ),
                    SizedBox(width: 10,),
                    Text('زيارة الموقع الرسمي' , style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                    ),)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Align the_title(String title) {
    return Align(
      alignment: AlignmentDirectional(-1, 0),
      child: Padding(
        padding: EdgeInsets.only(right: 5, left: 5, bottom: 5, top: 10),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            letterSpacing: 0.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding light_row( BuildContext context , String title) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
            Navigator.pushNamed(context, Routes.detailes);
        },
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromARGB(184, 220, 219, 218),
                width: 1,
              ),
            ),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

  Padding Dark_row(BuildContext context , String title) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, Routes.detailes);
        },
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(184, 220, 219, 218),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromARGB(184, 220, 219, 218),
                width: 0.5,
              ),
            ),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
