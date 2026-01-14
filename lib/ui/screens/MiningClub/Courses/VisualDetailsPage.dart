import 'package:eClassify/ui/screens/MiningClub/Courses/vedio_from_file_page.dart';
import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class VisualDetailsPage extends StatefulWidget {
  const VisualDetailsPage({super.key});

  @override
  State<VisualDetailsPage> createState() => _VisualDetailsPageState();
}

class _VisualDetailsPageState extends State<VisualDetailsPage> {

  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String? _lastDownloadedPath;

  final String videoUrl =
      'https://drive.google.com/uc?export=download&id=1HDY9Lu-nCcegQK6iUBa6wC-7OZ_6iznt';

  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      videoUrl,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isControllerInitialized) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: true,
        showControls: true,
        aspectRatio: 16 / 9,
        materialProgressColors: ChewieProgressColors(
          playedColor: Color(0xFFEBBE25),
          bufferedColor: Colors.grey,
          handleColor: Color(0xFFEBBE25),
          backgroundColor: Colors.grey.shade300,
        ),
      );

      _isControllerInitialized = true;
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Widget _videoActionsBar(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: SizedBox(
        height: 80,
        child: Row(
          // scrollDirection: Axis.horizontal,
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _actionItem(Icons.remove_red_eye, "985k"),
            _actionItem(Icons.thumb_up, "74K"),
            _actionItem(Icons.thumb_down, "2K"),
            _actionItem(Icons.share, "مشاركة" , onTap: _shareVideo),
            _actionItem(Icons.download, "تنزيل" , onTap: () => _downloadVideo(context)),
            _actionItem(Icons.bookmark, "حفظ"),
            _actionItem(Icons.flag, "إبلاغ"),
          ],
        ),
      ),
    );
  }

  Widget _actionItem(IconData icon, String label , {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFEBBE25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> _downloadVideo(BuildContext context) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath =
          '${dir.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      await Dio().download(
        videoUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      setState(() {
        _isDownloading = false;
        _lastDownloadedPath = savePath;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم تحميل الفيديو بنجاح'),
          action: SnackBarAction(
            label: 'فتح',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      VideoFromFilePage(filePath: savePath),
                ),
              );
            },
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تحميل الفيديو')),
      );
    }
  }



  void _shareVideo() {
    Share.share(
      'شاهد هذا الفيديو:\n$videoUrl',
      subject: 'فيديو مميز',
    );
  }

  @override
  Widget build(BuildContext context) {


    final Color goldColor = context.color.mainGold;
    Color star = Color.fromARGB(255, 227, 223, 223);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.mainBrown,
      ),
      backgroundColor: context.color.mainColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: _chewieController != null
                        ? AspectRatio(
                      aspectRatio: _chewieController!.videoPlayerController.value.aspectRatio,
                      child: Chewie(controller: _chewieController!),
                    )
                        : Center(child: CircularProgressIndicator()),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                  //   child: AspectRatio(
                  //     aspectRatio: 16 / 9,
                  //     child: Chewie(
                  //       controller: _chewieController!,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                    child: const Text(
                      "التعدين والمناجم رحله الي عمق الجبال ",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  if (_isDownloading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          const Text(
                            'جاري تحميل الفيديو...',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(value: _downloadProgress),
                          const SizedBox(height: 4),
                          Text('${(_downloadProgress * 100).toStringAsFixed(0)}%'),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            _videoActionsBar(context),
            // صورة الفيديو
            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15)),
            //   elevation: 3,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.all(5),
            //         child: Stack(
            //           children: [
            //             ClipRRect(
            //               borderRadius: BorderRadius.circular(12),
            //               child: Image.asset(
            //                 'assets/profile.jpg',
            //                 height: 200,
            //                 fit: BoxFit.cover,
            //                 width: double.infinity,
            //               ),
            //             ),
            //             const Positioned.fill(
            //               child: Center(
            //                 child: Icon(Icons.play_circle_fill,
            //                     color: Colors.white, size: 64),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Container(
            //         padding: EdgeInsets.only(left: 50, right: 10),
            //         child: const Text(
            //           "تشغيل الآليات مقارنة بين نموذج الإيجار والشراء",
            //           style:
            //               TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.start,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(height: 5),
            // Card(
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15)),
            //     elevation: 3,
            //     child: Column(children: [
            //       Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             _buildStat(Icons.remove_red_eye, "985,568"),
            //             _buildStat(Icons.thumb_up, "74,468"),
            //             _buildStat(Icons.comment, "15,244"),
            //             _buildStat(Icons.share, "مشاركة"),
            //           ],
            //         ),
            //       )
            //     ])),
            // const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/profile.jpg',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("قناة الوسيط للمقاولات ونفط حقل السمنت"),
                        Text("2.1 مليون مشترك",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        color: context.color.mainGold,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(5),
                    child: Center(child: Text('إشتراك')),
                  ),
                ],
              ),
            ),
            // الإحصائيات
            const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/profile.jpg',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        focusColor: context.color.mainBrown,
                        hintText: 'إضافة تعليق...',
                        prefixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: context.color.mainGold,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Text(
                              '4.7 تقييم و 183 مراجعة ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 3),
                                    child: LinearPercentIndicator(
                                      percent: 0.87,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      lineHeight: 13,
                                      animation: true,
                                      animateFromLastPercent: true,
                                      progressColor: context.color
                                          .mainGold, // اختر لون مناسب للتقدم
                                      backgroundColor:
                                      Color(0xFFE0E0E0), // لون الخلفية
                                      barRadius: Radius.circular(5),
                                      padding: EdgeInsets.zero,
                                      isRTL: true,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%87.5',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 3),
                                    child: LinearPercentIndicator(
                                      percent: 0.02,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      lineHeight: 13,
                                      animation: true,
                                      animateFromLastPercent: true,
                                      progressColor: context.color
                                          .mainGold, // اختر لون مناسب للتقدم
                                      backgroundColor:
                                      Color(0xFFE0E0E0), // لون الخلفية
                                      barRadius: Radius.circular(5),
                                      padding: EdgeInsets.zero,
                                      isRTL: true,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%02.0',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 3),
                                    child: LinearPercentIndicator(
                                      percent: 0.24,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      lineHeight: 13,
                                      animation: true,
                                      animateFromLastPercent: true,
                                      progressColor: context.color
                                          .mainGold, // اختر لون مناسب للتقدم
                                      backgroundColor:
                                      Color(0xFFE0E0E0), // لون الخلفية
                                      barRadius: Radius.circular(5),
                                      padding: EdgeInsets.zero,
                                      isRTL: true,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%24.7',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star,
                                            color: goldColor, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 3),
                                    child: LinearPercentIndicator(
                                      percent: 0.08,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      lineHeight: 13,
                                      animation: true,
                                      animateFromLastPercent: true,
                                      progressColor: context.color
                                          .mainGold, // اختر لون مناسب للتقدم
                                      backgroundColor:
                                      Color(0xFFE0E0E0), // لون الخلفية
                                      barRadius: Radius.circular(5),
                                      padding: EdgeInsets.zero,
                                      isRTL: true,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%08.0',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(5, 3, 5, 3),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3, 0, 3, 0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                        Icon(Icons.star, color: star, size: 20),
                                      ],
                                    ),
                                  ),
                                  Padding(

                                    padding:
                                    EdgeInsets.symmetric(horizontal: 3),
                                    child: LinearPercentIndicator(
                                      percent: 0.18,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      lineHeight: 13,
                                      animation: true,
                                      animateFromLastPercent: true,
                                      progressColor: context.color
                                          .mainGold, // اختر لون مناسب للتقدم
                                      backgroundColor:
                                      Color(0xFFE0E0E0), // لون الخلفية
                                      barRadius: Radius.circular(5),
                                      padding: EdgeInsets.zero,
                                      isRTL: true,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text('%18.5',
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: context.color.mainGold,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "التعليقات والتقييمات",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 5),
                      _buildReview(
                        name: "علاء الدين عبدالباقي",
                        date: "2024/6/19",
                        comment:
                        "هذا المحتوى هو فعلاً مميز، أن تعديل في نفس الساحة قد تم توضيحه للناس بشكل رائع، حيث تمكنك أداة الرد هنا من الرد أو التعديل في النصوص الأخرى بإضافة إلى زيادة عدد الحروف إلخ. شكراً للتنظيم.",
                      ),
                      _buildReview(
                        name: "علاء الدين عبدالباقي",
                        date: "2024/6/19",
                        comment:
                        "هذا المحتوى هو فعلاً مميز، أن تعديل في نفس الساحة قد تم توضيحه للناس بشكل رائع، حيث تمكنك أداة الرد هنا من الرد أو التعديل في النصوص الأخرى بإضافة إلى زيادة عدد الحروف إلخ. شكراً للتنظيم.",
                      ),
                      _buildReview(
                        name: "علاء الدين عبدالباقي",
                        date: "2024/6/19",
                        comment:
                        "هذا المحتوى هو فعلاً مميز، أن تعديل في نفس الساحة قد تم توضيحه للناس بشكل رائع، حيث تمكنك أداة الرد هنا من الرد أو التعديل في النصوص الأخرى بإضافة إلى زيادة عدد الحروف إلخ. شكراً للتنظيم.",
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 232, 187, 39),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 15,
          ),
          const SizedBox(width: 6),
          Text(count,
              style:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildReview(
      {required String name, required String date, required String comment}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle, size: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(date,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Icon(Icons.more_vert)
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star, color: Colors.amber, size: 20),
              Icon(Icons.star_half, color: Colors.amber, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment),
        ],
      ),
    );
  }
}

