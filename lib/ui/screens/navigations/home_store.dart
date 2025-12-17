// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eClassify/app/routes.dart';
import 'package:eClassify/data/cubits/category/fetch_category_cubit.dart';
import 'package:eClassify/data/cubits/chat/blocked_users_list_cubit.dart';
import 'package:eClassify/data/cubits/chat/get_buyer_chat_users_cubit.dart';
import 'package:eClassify/data/cubits/favorite/favorite_cubit.dart';
import 'package:eClassify/data/cubits/fetch_blogs_cubit.dart';
import 'package:eClassify/data/cubits/slider_cubit.dart';
import 'package:eClassify/data/cubits/system/fetch_system_settings_cubit.dart';
import 'package:eClassify/data/model/item/item_model.dart';
import 'package:eClassify/data/model/system_settings_model.dart';
import 'package:eClassify/ui/screens/home/GoldShimmerCard.dart';
import 'package:eClassify/ui/screens/home/slider_widget.dart';
import 'package:eClassify/ui/screens/home/widgets/category_widget_home.dart';
import 'package:eClassify/ui/screens/home/widgets/location_widget.dart';
import 'package:eClassify/ui/screens/widgets/CustomDrawerWidget.dart';
import 'package:eClassify/ui/screens/widgets/marqeeWidget.dart';
import 'package:eClassify/ui/theme/theme.dart';
//import 'package:uni_links/uni_links.dart';
import 'package:eClassify/utils/app_icon.dart';
import 'package:eClassify/utils/constant.dart';
import 'package:eClassify/utils/custom_text.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:eClassify/utils/hive_utils.dart';
import 'package:eClassify/utils/notification/awsome_notification.dart';
import 'package:eClassify/utils/notification/notification_service.dart';
import 'package:eClassify/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

const double sidePadding = 10;

class HomeStore extends StatefulWidget {
  final String? from;
  const HomeStore({super.key, this.from});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeStore>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeStore> {
  //
  int _rating = 4;
  @override
  bool get wantKeepAlive => true;

  //
  List<ItemModel> itemLocalList = [];

  //
  bool isCategoryEmpty = false;

  //
  late final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Color mainColor = Color(0xff271301);
  Color marqueeBgColor = Color(0xff150900);
  @override
  void initState() {
    super.initState();
    initializeSettings();
    addPageScrollListener();
    notificationPermissionChecker();
    LocalAwesomeNotification().init(context);
    ///////////////////////////////////////
    NotificationService.init(context);
    //for marquee
    context.read<FetchBlogsCubit>().fetchBlogs();
    //
    loadItemData();
    if (HiveUtils.isUserAuthenticated()) {
      context.read<FavoriteCubit>().getFavorite();
      //fetchApiKeys();
      context.read<GetBuyerChatListCubit>().fetch();
      context.read<BlockedUsersListCubit>().blockedUsersList();
    }
  }

  void _openCustomSideSheet(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent, // خلفية شفافة
      builder: (context) {
        return Align(
          alignment: Alignment.centerRight,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 0.70,
              color: Color.fromARGB(255, 66, 37, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: context.color.mainGold,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.close,
                      color: context.color.mainGold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: context.color.mainGold, width: 1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: UiUtils.getSvg(AppIcons.appbarLogo,
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Equipation@info.com",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void loadItemData() {
    context.read<SliderCubit>().fetchSlider(
          context,
        );
    context.read<FetchCategoryCubit>().fetchCategories();
    /*  context.read<FetchHomeScreenCubit>().fetch(
          city: HiveUtils.getCityName(),
          country: HiveUtils.getCountryName(),
          state: HiveUtils.getStateName(),
          radius: HiveUtils.getNearbyRadius(),
          longitude: HiveUtils.getLongitude(),
          latitude: HiveUtils.getLatitude(),
        );
    context.read<FetchHomeAllItemsCubit>().fetch(
        city: HiveUtils.getCityName(),
        radius: HiveUtils.getNearbyRadius(),
        longitude: HiveUtils.getLongitude(),
        latitude: HiveUtils.getLatitude(),
        country: HiveUtils.getCountryName(),
        state: HiveUtils.getStateName()); */
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initializeSettings() {
    final settingsCubit = context.read<FetchSystemSettingsCubit>();
    if (!const bool.fromEnvironment("force-disable-demo-mode",
        defaultValue: false)) {
      Constant.isDemoModeOn =
          settingsCubit.getSetting(SystemSetting.demoMode) ?? false;
    }
  }

  void addPageScrollListener() {
    //homeScreenController.addListener(pageScrollListener);
  }

  bool section1 = false;
  bool section2 = false;
  bool section3 = false;
  // bool section4 = false;
  // bool section5 = false;
  // bool section6 = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //leadingWidth: double.maxFinite,
          titleSpacing: 0,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profileScreen);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1, color: context.color.mainGold)),
                    child: Icon(Icons.person, color: context.color.mainGold),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: InkWell(
              //       onTap: () {
              //         showModalBottomSheet(
              //             context: context,
              //             isScrollControlled: true,
              //             backgroundColor: Colors.transparent,
              //             shape: RoundedRectangleBorder(
              //               borderRadius:
              //                   BorderRadius.vertical(top: Radius.circular(25)),
              //             ),
              //             builder: (context) => const CustomDrawerWidget());
              //         // _openCustomSideSheet(context);
              //       },
              //       child: Icon(Icons.menu)),
              // ),
              Padding(
                  padding: EdgeInsetsDirectional.only(end: sidePadding),
                  child: appbarTitleWidget()),
            ],
          ),

          backgroundColor: mainColor,
          foregroundColor: Colors.white,
          // backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          actions: appbarActionsWidget(),
        ),
        backgroundColor: mainColor,
        body: Column(
          children: [
            // InkWell(
            //   onTap: (){
            //     Navigator.pushNamed(context, Routes.welcome);
            //   },
            //   child: Icon(Icons.ac_unit),
            // ),
            blogMarqueeWidget(),
            Container(
                color: mainColor,
                padding: const EdgeInsetsDirectional.only(
                    start: sidePadding, end: sidePadding, bottom: 10, top: 0),
                alignment: AlignmentDirectional.centerStart,
                child: LocationWidget()),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: EdgeInsetsDirectional.only(top: 10, bottom: 80),
                decoration: BoxDecoration(
                    color: context.color.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  key: _refreshIndicatorKey,
                  color: context.color.mainBrown,
                  onRefresh: () async {
                    print("refresh-------");
                    loadItemData();
                  },
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(30, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 15, 0, 5),
                              child: Text(
                                "welcomeStore".translate(context),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'IBMPlexArabic'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 3, 0),
                              child: Text(
                                "welcomeStoreDesc".translate(context),
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'IBMPlexArabic'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 3, 0),
                              child: Text(
                                '',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'IBMPlexArabic'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const SliderWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        "welcomeStoreSlug".translate(context),
                        textAlign: TextAlign.center,
                        height: 1,
                        customTextStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (section1)
                              section1 = false;
                            else
                              section1 = true;
                          });
                        },


                        child: title_card("artisanalMining".translate(context), section1),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section1)
                        Padding(
                            padding: EdgeInsets.only(right: 15,left: 15,top: 10 , bottom: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                  custom_card_Item(
                                            context,
                                            ' شركة اكوبيشن',
                                            ''),
                                     custom_card_Item(
                                            context,
                                            'شركة اكوبيشن',
                                            ''),
                                   custom_card_Item(
                                            context,
                                            'شركة اكوبيشن',
                                            ''),
                                  ],
                                ),
                                // Divider( color: Colors.black, ),
                                // Row(
                                //   children: [
                                //     silver_card_Item(
                                //         context,
                                //         'أخبار التعدين',
                                //         ''),
                                //     silver_card_Item(
                                //         context,
                                //         'أخبار التعدين',
                                //         ''),
                                //     silver_card_Item(
                                //         context,
                                //         'أخبار التعدين',
                                //         ''),
                                //   ],
                                // ),
                                // Divider( color: Colors.black, ),
                                // Row(
                                //   children: [
                                //     card_Item(
                                //         context,
                                //         'أخبار التعدين',
                                //         ''),
                                //     card_Item(
                                //         context,
                                //         'أخبار التعدين',
                                //         ''),
                                //     card_Item(
                                //         context,
                                //         'أخبار التعدين',
                                //         ''),
                                //   ],
                                // ),

                              ],
                            )),

                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (section2)
                              section2 = false;
                            else
                              section2 = true;
                          });
                        },
                        child: title_card("miningSites".translate(context), section2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section2)
                        Padding(
                            padding: EdgeInsets.only(right: 15,left: 15,top: 10 , bottom: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    custom_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    custom_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    custom_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                  ],
                                ),
                                Divider( color: Colors.black, ),
                                Row(
                                  children: [
                                    silver_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    silver_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    silver_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                  ],
                                ),
                                Divider( color: Colors.black, ),
                                Row(
                                  children: [
                                    card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                  ],
                                ),

                              ],
                            )),
                      SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            if (section3)
                              section3 = false;
                            else
                              section3 = true;
                          });
                        },
                        child: title_card("businessServices".translate(context), section3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section3)
                        Padding(
                            padding: EdgeInsets.only(right: 15,left: 15,top: 10 , bottom: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    custom_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    custom_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    custom_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                  ],
                                ),
                                Divider( color: Colors.black, ),
                                Row(
                                  children: [
                                    silver_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    silver_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    silver_card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                  ],
                                ),
                                Divider( color: Colors.black, ),
                                Row(
                                  children: [
                                    card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                    card_Item(
                                        context,
                                        'أخبار التعدين',
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                  ],
                                ),

                              ],
                            )),
                      SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appbarTitleWidget() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            Constant.appName,
            fontSize: context.font.large,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          //UiUtils.getSvg(AppIcons.appbarLogo, height: 40, width: 40 ,fit: BoxFit.cover ),
        ]);
  }

  Widget appbarIconWidget(IconData icon, Function callback) {
    return IconButton(
        onPressed: () {
          callback();
        },
        icon: Icon(
          icon,
        ));
  }

  List<Widget> appbarActionsWidget() {
    return [
      appbarIconWidget(Icons.favorite_border, () {
        UiUtils.checkUser(
            onNotGuest: () {
              Navigator.pushNamed(context, Routes.favoritesScreen);
            },
            context: context);
      }),
      appbarIconWidget(Icons.search, () {
        Navigator.pushNamed(context, Routes.searchScreenRoute, arguments: {
          "autoFocus": true,
        });
      }),
      appbarIconWidget(Icons.notifications_active_outlined, () {
        UiUtils.checkUser(
            onNotGuest: () {
              Navigator.pushNamed(context, Routes.notificationPage);
            },
            context: context);
      }),
    ];
  }

  Widget blogMarqueeWidget() {
    return BlocBuilder<FetchBlogsCubit, FetchBlogsState>(
        builder: (context, state) {
      if (state is FetchBlogsSuccess) {
        String mergedTitle = state.blogModel.map((e) => e.title).join('\t\t\t');
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.blogsScreenRoute,
            );
          },
          child: Container(
            color: marqueeBgColor,
            padding: EdgeInsetsDirectional.symmetric(vertical: 5),
            child: MarqueeText(
              text: mergedTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
              velocity: 50,
            ),
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  Expanded custom_card_Item(BuildContext context, String title, String url) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right: 5, left: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                    height: 23,
                    decoration: BoxDecoration(
                      color: context.color.mainGold,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'المجموعة الذهبية',
                                style: TextStyle(
                                  fontSize: 8,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ]))),
            InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap : () {
                  Navigator.pushNamed(context, Routes.provideStore);
                },
                child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: context.color.mainGold,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3, 0, 3, 0),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.black,
                                                size: 10,
                                              ),
                                              Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(2, 0, 2, 0),
                                                  child: Text('177',
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black)))
                                            ])),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF4BBBE8),
                                    size: 15,
                                  ),
                                ]),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),

                                child: CachedNetworkImage(
                                  imageUrl:   'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.45%20AM.jpeg?alt=media&token=6786fe4b-3c6d-4989-b091-c317a302bb7b',
                                  width: double.infinity,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 3,),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                            List.generate(5, (index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _rating = index + 1;
                                                  });
                                                },
                                                child: Icon(
                                                  index < _rating
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 10,
                                                ),
                                              );
                                            }),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text('199 تقييم',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ]))),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text('  شركه إكوبيشن ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 7,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ]))),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: context.color.mainGold,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(' عرض ملف الشركة ',
                                          style: TextStyle(
                                            fontSize: 7,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ))
          ],
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   clipBehavior: Clip.hardEdge,
        //   child: Stack(
        //     children: [
        //       Positioned.fill(
        //         child: UiUtils.imageType(
        //           url,
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         left: 0,
        //         right: 0,
        //         child: Container(
        //           color: Colors.black.withValues(alpha: 0.5),
        //           padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        //           child: Text(
        //             title,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontWeight: FontWeight.w600,
        //               fontSize: context.font.small,
        //             ),
        //             textAlign: TextAlign.center,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Expanded silver_card_Item(BuildContext context, String title, String url) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right: 5, left: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                    height: 23,
                    decoration: BoxDecoration(
                      color: Color(0xFFA6A6A6),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'المجموعة الفضية',
                                style: TextStyle(
                                  fontSize: 8,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                        ]))),
            InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {},
                child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: context.color.mainGold,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3, 0, 3, 0),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.black,
                                                size: 10,
                                              ),
                                              Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(2, 0, 2, 0),
                                                  child: Text('177',
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors.black)))
                                            ])),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF4BBBE8),
                                    size: 15,
                                  ),
                                ]),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%209.09.46%20AM.jpeg?alt=media&token=6c04b17b-6218-42bf-83db-dbf3b4a91f9a',
                                  width: double.infinity,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 3,),
                            Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                            List.generate(5, (index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _rating = index + 1;
                                                  });
                                                },
                                                child: Icon(
                                                  index < _rating
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 10,
                                                ),
                                              );
                                            }),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text('199 تقييم',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ]))),
                            Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text('مجموعة شركات شموخ قطر',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 7,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ]))),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: context.color.mainGold,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(' عرض ملف الشركة ',
                                          style: TextStyle(
                                            fontSize: 7,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ))
          ],
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   clipBehavior: Clip.hardEdge,
        //   child: Stack(
        //     children: [
        //       Positioned.fill(
        //         child: UiUtils.imageType(
        //           url,
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         left: 0,
        //         right: 0,
        //         child: Container(
        //           color: Colors.black.withValues(alpha: 0.5),
        //           padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        //           child: Text(
        //             title,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontWeight: FontWeight.w600,
        //               fontSize: context.font.small,
        //             ),
        //             textAlign: TextAlign.center,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Expanded card_Item(BuildContext context, String title, String url) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right: 5, left: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {},
                child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: context.color.mainGold,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            3, 0, 3, 0),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.black,
                                                size: 10,
                                              ),
                                              Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(2, 0, 2, 0),
                                                  child: Text('177',
                                                      style: TextStyle(
                                                          fontSize: 8,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: Colors.black)))
                                            ])),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF4BBBE8),
                                    size: 15,
                                  ),
                                ]),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2FWhatsApp%20Image%202024-12-18%20at%202.37.57%20PM%20(1).jpeg?alt=media&token=297caa0c-7fe8-4770-8af0-bff9484df17e',
                                  width: double.infinity,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 3,),
                            Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                            List.generate(5, (index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _rating = index + 1;
                                                  });
                                                },
                                                child: Icon(
                                                  index < _rating
                                                      ? Icons.star
                                                      : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 10,
                                                ),
                                              );
                                            }),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text('199 تقييم',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 8,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ])
                                )),
                            Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(3),
                                            child: Text('مجموعة شركات شموخ قطر',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 7,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                        ]))),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: context.color.mainGold,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(' عرض ملف الشركة ',
                                          style: TextStyle(
                                            fontSize: 7,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ))
          ],
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   clipBehavior: Clip.hardEdge,
        //   child: Stack(
        //     children: [
        //       Positioned.fill(
        //         child: UiUtils.imageType(
        //           url,
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         left: 0,
        //         right: 0,
        //         child: Container(
        //           color: Colors.black.withValues(alpha: 0.5),
        //           padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        //           child: Text(
        //             title,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontWeight: FontWeight.w600,
        //               fontSize: context.font.small,
        //             ),
        //             textAlign: TextAlign.center,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Container title_card(String title, bool section) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            section ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          Expanded(
            child: CustomText(
              title,
              // item.name ?? "",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            section ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

Future<void> notificationPermissionChecker() async {
  if (!(await Permission.notification.isGranted)) {
    await Permission.notification.request();
  }
}
