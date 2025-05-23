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
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(25)),
                          ),
                          builder: (context) => const CustomDrawerWidget());
                      // _openCustomSideSheet(context);
                    },
                    child: Icon(Icons.menu)),
              ),
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
                  color: context.color.territoryColor,
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
                                'أهلاً بك في اخبار بريق!',
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
                                'حيث نضع كلما تبحث عنه امام عينيك ،',
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
                                'لتكون علي خطوة واحدة عن عالم التعدين.',
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
                        'دليل الاخبار بين يديك',
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
                        child: title_card('اخبار التعدين والشركات' , section1),
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
                                        title: 'أخبار التعدين',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/pn7ueo7p1ys1/4-_%D9%85%D8%AF%D9%88%D9%86%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.soon);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' أخبار الشركات ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/cchsh9teg1dp/3-_%D9%85%D9%8A%D9%83%D8%B1%D9%88%D9%81%D9%88%D9%86_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.soon);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' تحديثات الجهات الرسمية والوزارات ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/mina24dtpbp3/13_copy.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.soon);
                                    },
                                    child: custom_card_Item(
                                        context,
                                        ' لمستجدات التشريعية والتنظيمية ',
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/jao8sn6i4a6t/62_copy.jpg'),
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
                        child: title_card('لأسواق والأسعار' , section2),
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
                                        title: ' بورصة المعادن ',
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2F4-%20%D8%A7%D9%84%D9%85%D9%82%D8%A7%D9%84%D8%A7%D8%AA%20%D8%A7%D9%84%D8%B9%D9%84%D9%85%D9%8A%D8%A9.jpg?alt=media&token=a718d3dc-a85e-46f1-9c24-aef3f06ab8dc'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.mony_exchange);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' أسعار العملات ',
                                        url:
                                        'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/appimg%2F4-%20%D8%A7%D9%84%D9%85%D9%82%D8%A7%D9%84%D8%A7%D8%AA%20%D8%A7%D9%84%D8%B9%D9%84%D9%85%D9%8A%D8%A9.jpg?alt=media&token=a718d3dc-a85e-46f1-9c24-aef3f06ab8dc'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.soon);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' تقارير سوقية وتحليلات اقتصادية ',
                                        url: 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/wzgkssd9rseh/71_copy.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.soon);
                                    },
                                    child: custom_card_Item(
                                        context,
                                        ' رسوم بيانية ومؤشرات فنية ',
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/wzgkssd9rseh/71_copy.jpg'),
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
                        child: title_card('المعرفة والبحوث' , section3),
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
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' المقالات العلمية والتحليلية ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/68p8l6cu6qxc/2-_%D9%85%D8%AC%D9%84%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' البحوث والأوراق الأكاديمية ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/68p8l6cu6qxc/2-_%D9%85%D8%AC%D9%84%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.guide);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' المواد الدراسية والكتب ',
                                        url: 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/68p8l6cu6qxc/2-_%D9%85%D8%AC%D9%84%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.guide);
                                    },
                                    child: custom_card_Item(
                                        context,
                                        ' المشاريع البحثية المدعومة ',
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/68p8l6cu6qxc/2-_%D9%85%D8%AC%D9%84%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
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
                        child: title_card('الدورات والتأهيل' , section4),
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
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: 'الدورات التدريبية ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/lml0fa6t0p56/73_copy.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' الندوات وورش العمل ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/lml0fa6t0p56/73_copy.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.guide);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' برامج تطوير المهارات ',
                                        url: 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/lml0fa6t0p56/73_copy.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.guide);
                                    },
                                    child: custom_card_Item(
                                        context,
                                        ' الشهادات المتخصصة في التعدين ',
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/lml0fa6t0p56/73_copy.jpg'),
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
                        child: title_card('الميديا والبودكاست' , section5),
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
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' بودكاست التعدين ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/cchsh9teg1dp/3-_%D9%85%D9%8A%D9%83%D8%B1%D9%88%D9%81%D9%88%D9%86_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' فيديوهات توعوية وتدريبية ',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/r878vk5z12ae/1-_%D9%82%D9%86%D8%A7%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86_(1).jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.guide);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' جلسات حوارية ومسجلة ',
                                        url: 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/wfn2teddfaml/70_copy.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.guide);
                                    },
                                    child: custom_card_Item(
                                        context,
                                        ' عروض تقديمية مرئية ',
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/r878vk5z12ae/1-_%D9%82%D9%86%D8%A7%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86_(1).jpg'),
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       ' الولايات والمحاليات  ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/irp2v834y4x6/12_copy.jpg'),
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       ' المالية والتخطيط الأقتصادي  ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/mina24dtpbp3/13_copy.jpg'),
                                  // ),
                                  //
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       ' هيئة الجمارك ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/pxyx3p1md655/14_copy.jpg'),
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       ' وزارة التجارة ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/vq8ys7favedu/15_copy.jpg'),
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       ' مكتب العمل ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/a5ozl80fvqk4/16_copy.jpg'),
                                  // ),

                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       'وزارة العدل ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/aqm2fk2oi1cm/17_copy.jpg'),
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       ' التأمينات الإجتماعية ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/6iqubtvxmlic/18_copy.jpg'),
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(context, Routes.guide);
                                  //   },
                                  //   child: custom_card_Item(
                                  //       context,
                                  //       ' شركات التأمين ',
                                  //       'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/80k6u2xj7rn9/19_copy.jpg'),
                                  // ),
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
                        child: title_card('المجتمع والمبادرات' , section6),
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
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: 'المبادرات المجتمعية',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/x33ybf804qm1/74.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.blogsScreenRoute);
                                    },
                                    child: GoldShimmerCard(
                                        title: 'المسؤولية الاجتماعية',
                                        url:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/x33ybf804qm1/74.jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.soon);
                                    },
                                    child: GoldShimmerCard(
                                        title: ' المنتديات والنقاشات ',
                                        url: 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/r878vk5z12ae/1-_%D9%82%D9%86%D8%A7%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86_(1).jpg'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.soon);
                                    },
                                    child: custom_card_Item(
                                        context,
                                        ' مدونة بريق ',
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/mining-market-firebase-ym2dfj/assets/pn7ueo7p1ys1/4-_%D9%85%D8%AF%D9%88%D9%86%D8%A9_%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86.jpg'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 5,
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
