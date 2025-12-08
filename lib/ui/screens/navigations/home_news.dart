// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
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

class HomeNews extends StatefulWidget {
  final String? from;
  const HomeNews({super.key, this.from});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeNews>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeNews> {
  //
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
  bool section4 = false;
  bool section5 = false;
  bool section6 = false;

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
                                "welcomeNews".translate(context),
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
                                "welcomeNewsDesc".translate(context),
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
                        "welcomeNewsSlug".translate(context),
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
                            if(section1)
                            section1 = false;
                            else section1 = true;
                          });
                        },
                        child: title_card("miningCompanyNews".translate(context) , section1),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section1)
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
                                      Navigator.pushNamed(
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: "miningNews".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F44-%20%D8%A7%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpeg.jpg?alt=media&token=602fdc8e-de80-42f7-934f-b41ab9ddfcaa'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: "companyNews".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F61-%20%D8%A3%D8%AE%D8%A8%D8%A7%D8%B1%20%D8%A7%D9%84%D8%B4%D8%B1%D9%83%D8%A7%D8%AA.jpg?alt=media&token=c9a5210e-85ea-49c4-b146-b16936e21879'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: "officialUpdates".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F45-%20%D8%AA%D8%AD%D8%AF%D9%8A%D8%AB%D8%A7%D8%AA%20%D8%A7%D9%84%D8%AC%D9%87%D8%A7%D8%AA.jpeg.jpg?alt=media&token=3181874b-3bcf-4f46-8195-8cb905b9bcc8'),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            if(section2)
                              section2 = false;
                            else section2 = true;
                          });
                        },
                        child: title_card("marketsPrices".translate(context) , section2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section2)
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
                                      Navigator.pushNamed(
                                          context, Routes.mining_exchange);
                                    },
                                    child: GoldShimmerCard(
                                        title: "metalsExchange".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F46-%20%D8%A8%D9%88%D8%B1%D8%B5%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%AF%D9%86.jpg?alt=media&token=bfcf5a8f-ee16-4da7-8ce4-aca6e530a9f0'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.mony_exchange);
                                    },
                                    child: GoldShimmerCard(
                                        title: "currencyPrices".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F47-%20%D8%A7%D8%B3%D8%B9%D8%A7%D8%B1%20%D8%A7%D9%84%D8%B9%D9%85%D9%84%D8%A7%D8%AA.jpg?alt=media&token=e99250f6-6ec0-4ea4-aaa0-e8192c7e5622'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.soon);
                                    },
                                    child: GoldShimmerCard(
                                        title:"marketReports".translate(context),
                                        url: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F48-%20%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%B3%D9%88%D9%82.jpg?alt=media&token=a4090223-34c3-4650-b8e0-ddecef16c131'),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            if(section3)
                              section3 = false;
                            else section3 = true;
                          });
                        },
                        child: title_card("knowledgeResearch".translate(context), section3),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section3)
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
                                      Navigator.pushNamed(
                                        context,
                                        Routes.knowResPage,
                                        arguments:
                                        {
                                          'title': "analyticalArticles".translate(context),
                                          'flag': '1',
                                        }, // هذا هو الـ title
                                      );
                                    },
                                    child: GoldShimmerCard(
                                        title: "academicPapers".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F49-%20%D8%A7%D9%84%D9%85%D9%82%D8%A7%D9%84%D8%A7%D8%AA%20%D8%A7%D9%84%D8%B9%D9%84%D9%85%D9%8A%D8%A9.jpg?alt=media&token=b61674c1-3a73-400c-9115-c271ef6abefb'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                      Routes.knowResPage,
                                      arguments: {
                                        'title' : "studyMaterialsBooks".translate(context),
                                        'flag' : '2'
                                      });
                                    },
                                    child: GoldShimmerCard(
                                        title: "academicPapers".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F50-%20%D8%A7%D9%84%D8%A8%D8%AD%D9%88%D8%AB%20%D9%88%D8%A7%D9%84%D8%A7%D9%88%D8%B1%D8%A7%D9%82%20%D8%A7%D9%84%D8%AD%D9%83%D9%88%D9%85%D9%8A%D8%A9.jpg?alt=media&token=01a9018a-4301-4340-a120-87a4abd26a08'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          Routes.knowResPage,
                                          arguments: {
                                            'title' : "studyMaterialsBooks".translate(context),
                                            'flag' : '2'
                                          });
                                    },
                                    child: GoldShimmerCard(
                                        title: "studyMaterialsBooks".translate(context),
                                        url: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F51-%20%D8%A7%D9%84%D9%85%D9%88%D8%A7%D8%AF%20%D8%A7%D9%84%D8%AF%D8%B1%D8%A7%D8%B3%D9%8A%D8%A9.jpg?alt=media&token=5bb3b27e-8990-4465-bb2f-a0eea1f9948d'),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            if(section4)
                              section4 = false;
                            else section4 = true;
                          });
                        },
                        child: title_card("coursesTraining".translate(context) , section4),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section4)
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
                                      Navigator.pushNamed(
                                          context, Routes.visualMaterialsPage);
                                    },
                                    child: GoldShimmerCard(
                                        title: "trainingCourses".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F52-%20%D8%A7%D9%84%D8%AF%D9%88%D8%B1%D8%A7%D8%AA%20%D8%A7%D9%84%D8%AA%D8%AF%D8%B1%D9%8A%D8%A8%D9%8A%D8%A9.jpg?alt=media&token=2b1e0b66-8b1f-42f3-bfca-df78ba5416c5'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.visualMaterialsPage);
                                    },
                                    child: GoldShimmerCard(
                                        title: "seminarsWorkshops".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F53-%20%D8%A7%D9%84%D9%86%D8%AF%D9%88%D8%A7%D8%AA%20%D9%88%D9%88%D8%B1%D8%B4%20%D8%A7%D9%84%D8%AA%D8%AF%D8%B1%D9%8A%D8%A8.jpeg.jpg?alt=media&token=f1a77b7d-d664-4de4-82f5-88d0257e1835'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.visualMaterialsPage);
                                    },
                                    child: GoldShimmerCard(
                                        title: "skillsDevPrograms".translate(context),
                                        url: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F54-%20%D8%A8%D8%B1%D8%A7%D9%85%D8%AC%20%D8%AA%D8%B7%D9%88%D9%8A%D8%B1%20%D8%A7%D9%84%D9%85%D9%87%D8%A7%D8%B1%D8%A7%D8%AA.jpg?alt=media&token=5aa798d3-130d-400f-ac50-fea7b719b22a'),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            if(section5)
                              section5 = false;
                            else section5 = true;
                          });
                        },
                        child: title_card("mediaPodcasts".translate(context) , section5),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section5)
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
                                      Navigator.pushNamed(
                                          context, Routes.bodcastPage);
                                    },
                                    child: GoldShimmerCard(
                                        title:"miningPodcast".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F55-%20%D8%A8%D9%88%D8%AF%D9%83%D8%A7%D8%B3%D8%AA%20%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg?alt=media&token=1ac4ecef-b0c4-44b2-9999-bc03a78184df'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.bodcastPage);
                                    },
                                    child: GoldShimmerCard(
                                        title: "trainingVideos".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F56-%20%D9%81%D9%8A%D8%AF%D9%8A%D9%88%D9%87%D8%A7%D8%AA%20%D8%AA%D9%88%D8%B9%D9%88%D9%8A%D8%A9.jpg?alt=media&token=5b853c97-11b6-4f23-b0ad-7a5e14eaad30'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.bodcastPage);
                                    },
                                    child: GoldShimmerCard(
                                        title: "discussionSessions".translate(context),
                                        url: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F57-%20%D8%AC%D9%84%D8%B3%D8%A7%D8%AA%20%D8%AD%D9%88%D8%A7%D8%B1%D9%8A%D8%A9.jpeg.jpg?alt=media&token=bc908f40-0b99-4f29-8c57-2f7e9cccac68'),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap: () {
                          setState(() {
                            if(section6)
                              section6 = false;
                            else section6 = true;
                          });
                        },
                        child: title_card("communityInitiatives".translate(context) , section6),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (section6)
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
                                      Navigator.pushNamed(
                                          context, Routes.communitiesPage,arguments: {
                                        'title':"communityInitiativesItems".translate(context),
                                        'flag' : '1'
                                      });
                                    },
                                    child: GoldShimmerCard(
                                        title: "communityInitiativesItems".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F60-%20%D8%A7%D9%84%D9%85%D8%A8%D8%A7%D8%AF%D8%B1%D8%A7%D8%AA%20%D8%A7%D9%84%D9%85%D8%AC%D8%AA%D9%85%D8%B9%D9%8A%D8%A9.jpg?alt=media&token=bc386fd0-36a3-4896-89dc-74064cd0f7f0'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.communitiesPage,arguments: {
                                        'title' : "socialResponsibility".translate(context),
                                        'flag' : '2'
                                      });
                                    },
                                    child: GoldShimmerCard(
                                        title: "socialResponsibility".translate(context),
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F59-%20%D8%A7%D9%84%D9%85%D8%B3%D8%A4%D9%88%D9%84%D9%8A%D8%A9%20%D8%A7%D9%84%D9%85%D8%AC%D8%AA%D9%85%D8%B9%D9%8A%D8%A9.jpg?alt=media&token=cdbe9c70-eb12-4fb9-941f-a8391ec72251'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.communitiesPage,arguments: {
                                        'title' : "forumsDiscussions".translate(context),
                                        'flag' : '3'
                                      });
                                    },
                                    child: GoldShimmerCard(
                                        title: "forumsDiscussions".translate(context),
                                        url: 'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/Miningclub%2F58-%20%D8%A7%D9%84%D9%85%D9%86%D8%AA%D8%AF%D9%8A%D8%A7%D8%AA%20%D9%88%D8%A7%D9%84%D9%86%D9%82%D8%A7%D8%B4%D8%A7%D8%AA.jpg?alt=media&token=e5c7a67e-d4c0-4acc-b9d4-58e4b78c8279'),
                                  ),
                                  SizedBox(height: 5,)
                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 30,
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

  Container custom_card_Item(BuildContext context, String title, String url) {
    return Container(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container title_card(String title , bool section) {
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
