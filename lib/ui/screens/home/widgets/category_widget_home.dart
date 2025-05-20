import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/cubits/category/fetch_category_cubit.dart';
import 'package:eClassify/data/model/category_model.dart';
import 'package:eClassify/ui/screens/home/GoldShimmerCard.dart';
import 'package:eClassify/ui/screens/home/home_screen.dart';
import 'package:eClassify/ui/screens/home/widgets/category_home_card.dart';
import 'package:eClassify/ui/screens/main_activity.dart';
import 'package:eClassify/ui/screens/widgets/errors/no_data_found.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/app_icon.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/hive_utils.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String expandedCategroryId = HiveUtils.getExpandedCategoryId() ?? "";
String categoryTitleHeader = 'إعلانات التعدين بين يديك';
bool isFixExpanded = false;

class CategoryWidgetHome extends StatefulWidget {
  const CategoryWidgetHome({super.key});

  @override
  State<CategoryWidgetHome> createState() => _CategoryWidgetHomeState();
}

class _CategoryWidgetHomeState extends State<CategoryWidgetHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchCategoryCubit, FetchCategoryState>(
      builder: (context, state) {
        if (state is FetchCategorySuccess) {
          if (state.categories.isNotEmpty) {
            return Column(
              spacing: 12,
              children: [
                const SizedBox(height: 1),
                CustomText(
                  categoryTitleHeader,
                  height: 1,
                  customTextStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),

                // The link for the Page
                InkWell(
                  onTap: () {
                    if (isFixExpanded)
                      setState(() {
                        isFixExpanded = false;
                      });
                    else
                      setState(() {
                        isFixExpanded = true;
                      });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 13),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppIcons.categoryBg),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isFixExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: CustomText(
                            'دلـيل الإرشـاد الإجرائي',
                            // item.name ?? "",
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          isFixExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                if (isFixExpanded)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: [
                            // The Card
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: GoldShimmerCard( title : 'المسجل التجاري',
                                 url:'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/23dwc45aegqv/8_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: GoldShimmerCard(
                                  title : ' وزارة الإستثمار ',
                                  url : 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/8iy777zlezzx/9_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: GoldShimmerCard(
                                  title: '   وزارة المعادن ',
                                  url: 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/kqgp4p9tgsdw/10_copy.jpg'),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' الابحاث الجيلوجية ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/fu508h0w64cp/11_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' الولايات والمحاليات  ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/irp2v834y4x6/12_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' المالية والتخطيط الأقتصادي  ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/mina24dtpbp3/13_copy.jpg'),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' هيئة الجمارك ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/pxyx3p1md655/14_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' وزارة التجارة ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/vq8ys7favedu/15_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' مكتب العمل ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/a5ozl80fvqk4/16_copy.jpg'),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  'وزارة العدل ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/aqm2fk2oi1cm/17_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' التأمينات الإجتماعية ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/6iqubtvxmlic/18_copy.jpg'),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.guide);
                              },
                              child: custom_card_Item(
                                  context,
                                  ' شركات التأمين ',
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/80k6u2xj7rn9/19_copy.jpg'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                categoryWidget(state.categories),
              ],
            );

            /*  return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                width: context.screenWidth,
                height: 103,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: sidePadding,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (state.categories.length > 10 &&
                        index == state.categories.length) {
                      return moreCategory(context);
                    } else {
                      return CategoryHomeCard(
                        title: state.categories[index].name!,
                        url: state.categories[index].url!,
                        onTap: () {
                          if (state.categories[index].children!.isNotEmpty) {
                            Navigator.pushNamed(
                                context, Routes.subCategoryScreen,
                                arguments: {
                                  "categoryList":
                                      state.categories[index].children,
                                  "catName": state.categories[index].name,
                                  "catId": state.categories[index].id,
                                  "categoryIds": [
                                    state.categories[index].id.toString()
                                  ]
                                });
                          } else {
                            Navigator.pushNamed(context, Routes.itemsList,
                                arguments: {
                                  'catID':
                                      state.categories[index].id.toString(),
                                  'catName': state.categories[index].name,
                                  "categoryIds": [
                                    state.categories[index].id.toString()
                                  ]
                                });
                          }
                        },
                      );
                    }
                  },
                  itemCount: state.categories.length > 10
                      ? state.categories.length + 1
                      : state.categories.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 12,
                    );
                  },
                ),
              ),
            );
         */
          } else {
            return Padding(
              padding: const EdgeInsets.all(50.0),
              child: NoDataFound(
                onTap: () {},
              ),
            );
          }
        }
        if (state is FetchCategoryInProgress) {
          return UiUtils.progress();
        }
        if (state is FetchCategoryFailure) {
          return NoDataFound(
            mainMessage: state.errorMessage,
          );
        }
        return Container();
      },
    );
  }

  Container custom_card_Item(BuildContext context, String title, String url) {
    return
      Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: UiUtils.imageType(
                url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: context.font.small,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget moreCategory(BuildContext context) {
    return SizedBox(
      width: 70,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.categories,
              arguments: {"from": Routes.home}).then(
            (dynamic value) {
              if (value != null) {
                selectedCategory = value;
                //setState(() {});
              }
            },
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                      color:
                          context.color.textLightColor.withValues(alpha: 0.33),
                      width: 1),
                  color: context.color.secondaryColor,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      // color: Colors.blue,
                      width: 48,
                      height: 48,
                      child: Center(
                        child: RotatedBox(
                            quarterTurns: 1,
                            child: UiUtils.getSvg(AppIcons.more,
                                color: context.color.territoryColor)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: CustomText(
                        "more".translate(context),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        color: context.color.textDefaultColor,
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(List<CategoryModel> categories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        if (categories.length > 10 && index == categories.length) {
          return moreCategory(context);
        }
        final item = categories[index];
        bool isExpanded = expandedCategroryId == item.id.toString();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          /*  decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber, width: 1),
          ), */
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (item.children!.isNotEmpty) {
                    setState(() {
                      expandedCategroryId =
                          isExpanded ? '' : item.id.toString();
                    });
                    HiveUtils.setExpandedCategoryId(expandedCategroryId);
                  } else {
                    Navigator.pushNamed(context, Routes.itemsList, arguments: {
                      'catID': item.id.toString(),
                      'catName': item.name,
                      "categoryIds": [item.id.toString()]
                    });
                  }
                },
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppIcons.categoryBg),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: CustomText(
                              item.name ?? "",
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isExpanded)
                subCategoryWidget(item.children!, item.id ?? 0, item.name ?? "")
            ],
          ),
        );
      },
    );
  }

  Widget subCategoryWidget(
      List<CategoryModel> subcategories, int categoryId, String categoryName) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          if (subcategories.length > 6) ...[
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.subCategoryScreen,
                      arguments: {
                        "categoryList": subcategories,
                        "catName": categoryName,
                        "catId": categoryId,
                        "categoryIds": [categoryId.toString()]
                      });
                },
                child: CustomText(
                  "seeAll".translate(context),
                  showUnderline: true,
                  fontSize: context.font.smaller + 3,
                ),
              ),
            ),
            const SizedBox(height: 5)
          ],
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(
              subcategories.length > 6 ? 6 : subcategories.length,
              (i) {
                final subcategory = subcategories[i];
                return GestureDetector(
                  onTap: () {
                    if (subcategory.children!.isEmpty &&
                        subcategory.subcategoriesCount == 0) {
                      Navigator.pushNamed(context, Routes.itemsList,
                          arguments: {
                            'catID': subcategory.id.toString(),
                            'catName': subcategory.name,
                            "categoryIds": [
                              categoryId.toString(),
                              subcategory.id.toString()
                            ]
                          });
                    } else {
                      Navigator.pushNamed(context, Routes.subCategoryScreen,
                          arguments: {
                            "categoryList": subcategory.children,
                            "catName": subcategory.name,
                            "catId": subcategory.id,
                            "categoryIds": [
                              categoryId.toString(),
                              subcategory.id.toString()
                            ]
                          });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: UiUtils.imageType(
                            subcategory.url ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.5),
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              subcategory.name ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: context.font.small,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
