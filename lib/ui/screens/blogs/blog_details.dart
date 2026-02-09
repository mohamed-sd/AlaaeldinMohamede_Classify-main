import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/model/blog_model.dart';

import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BlogDetails extends StatelessWidget {
  final BlogModel blog;

  const BlogDetails({super.key, required this.blog});

  static Route route(RouteSettings settings) {
    Map? arguments = settings.arguments as Map;
    return MaterialPageRoute(
      builder: (context) {
        return BlogDetails(
          blog: arguments['model'],
        );
      },
    );
  }

  String stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String strippedString = htmlString.replaceAll(exp, '');
    return strippedString;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.color.primaryColor,
        // appBar: UiUtils.buildAppBar(context, backgroundColor: context.color.mainBrown,
        //     showBackButton: true, title: "blogs".translate(context)),
        appBar: AppBar(
            backgroundColor: context.color.mainBrown,
            title: Text("blogs".translate(context))),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(
              20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  child: SizedBox(
                    width: context.screenWidth,
                    height: 170,
                    child: UiUtils.getImage(
                      blog.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // انشاء كارد حساب المعلن
                // وهو كارد يحتوي علي بيانات من عمل الاعلان
                CustomText(
                  blog.createdAt.toString().formatDate(),
                  color: context.color.textColorDark.withValues(alpha: 0.5),
                  fontSize: context.font.smaller,
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.blogprofile);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.person_2),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                "احمد عبد الوهاب",
                                fontSize: context.font.normal,
                                color: context.color.textColorDark,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              CustomText(
                                "ah.ahmedsamba@gmail.com",
                                fontSize: context.font.small,
                                color: context.color.textColorDark
                                    .withValues(alpha: 0.6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  (blog.title ?? "").firstUpperCase(),
                  color: context.color.textColorDark,
                  fontSize: context.font.large,
                ),
                const SizedBox(
                  height: 14,
                ),
                HtmlWidget(blog.description ?? "")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
