
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class Detailes extends StatefulWidget {
  const Detailes({super.key});

  static String routeName = 'privacy_screen';
  static String routePath = '/privacyScreen';

  @override
  State<Detailes> createState() => _PrivacyScreenWidgetState();
}

class _PrivacyScreenWidgetState extends State<Detailes> {

  //late PrivacyScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_model = createModel(context, () => PrivacyScreenModel());
    // logFirebaseEvent('screen_view',
    //     parameters: {'screen_name': 'privacy_screen'});
    // WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    //_model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: context.color.mainGold,
        appBar: AppBar(
          backgroundColor: context.color.mainGold,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  color: context.color.mainBrown,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 10, 10),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                                  margin: EdgeInsets.only(top: 20, right: 20 , left: 20),
                                  decoration:BoxDecoration(
                                    color: context.color.mainGold,
                                    borderRadius: BorderRadiusDirectional.circular(15)
                                  ),
                                  child: Text('اجراءات رخصة البحث العامة',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                  ),),
                                ),
                                Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                                margin: EdgeInsets.symmetric(vertical: 20),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(15)
                                ),
                                child: Text('اجراءات رخصة البحث العامة',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
