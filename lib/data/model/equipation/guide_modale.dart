class GuideModale {
  String title ;
  String content;
  GuideModale({required this.title ,required this.content});
}

class GuideCatModale{
  String flag ;
  // List<String> titles ;
  List<GuideTitleModel> titles;


  GuideCatModale({required this.flag , required this.titles});
}

class GuideTitleModel {
  String text;
  String imagePath;

  GuideTitleModel({
    required this.text,
    required this.imagePath,
  });
}