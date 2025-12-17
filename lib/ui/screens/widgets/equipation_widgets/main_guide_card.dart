import 'package:cached_network_image/cached_network_image.dart';
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/model/equipation/guide_modale.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class MainGuideCard extends StatelessWidget {
  String title;
  String urlimg;

  MainGuideCard({super.key, required this.title, required this.urlimg});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 6, spreadRadius: 3)
            ]),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:CachedNetworkImage(
                  imageUrl: urlimg,
                  height: 100,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 5,
              ),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Color(0xff844F03),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ));
    // return  Expanded(
    //     child: Padding(
    //         padding: EdgeInsets.all(3),
    //         child: Material(
    //             color: Colors.transparent,
    //             elevation: 5,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(15),
    //             ),
    //             child: Container(
    //                 width: double.infinity,
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius:
    //                   BorderRadius.circular(15),
    //                 ),
    //                 child: Padding(
    //                     padding: EdgeInsets.all(5),
    //                     child: Column(
    //                         mainAxisSize:
    //                         MainAxisSize.max,
    //                         mainAxisAlignment:
    //                         MainAxisAlignment.center,
    //                         children: [
    //                           ClipRRect(
    //                             borderRadius:
    //                             BorderRadius.circular(
    //                                 10),
    //                             child: Image.network(
    //                               urlimg,
    //                               width: double.infinity,
    //                               height:
    //                               MediaQuery.sizeOf(
    //                                   context)
    //                                   .height *
    //                                   0.15,
    //                               fit: BoxFit.fill,
    //                             ),
    //                           ),
    //                           Padding(
    //                               padding:
    //                               EdgeInsetsDirectional
    //                                   .fromSTEB(
    //                                   0, 5, 0, 5),
    //                               child: Row(
    //                                   mainAxisSize:
    //                                   MainAxisSize
    //                                       .max,
    //                                   children: [
    //                                     Flexible(
    //                                         child: Container(
    //                                             width: double.infinity,
    //                                             decoration: BoxDecoration(
    //                                               color: Color(0xff844F03),
    //                                               borderRadius:
    //                                               BorderRadius.circular(5),
    //                                             ),
    //                                             child: Padding(
    //                                                 padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
    //                                                 child: Row(mainAxisSize: MainAxisSize.max, children: [
    //                                                   Expanded(
    //                                                     child: Align(
    //                                                         alignment: AlignmentDirectional(0, 0),
    //                                                         child: Padding(
    //                                                           padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 3),
    //                                                           child: Text(title,
    //                                                               style: TextStyle(
    //                                                                 color: Colors.white,
    //                                                                 fontSize: 12,
    //                                                                 letterSpacing: 0.0,
    //                                                                 fontWeight: FontWeight.w700,
    //                                                               )),
    //                                                         )),
    //                                                   )
    //                                                 ])))),
    //                                   ])),
    //
    //
    //
    //
    //
    //                         ]
    //                     )
    //                 )
    //             )
    //         )));
  }
}

class MainListCard extends StatelessWidget {
  String title;
  String urlimg;

  MainListCard({super.key, required this.title, required this.urlimg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        // width: 170,
        margin: EdgeInsets.only(top: 10 , right: 10 , left: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 6, spreadRadius: 3)
            ]),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: urlimg,

                height: 130,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 5,
              ),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Color(0xff844F03),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                title,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
