import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatelessWidget {
  const PDFViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" المستند ") , backgroundColor: context.color.mainBrown,),
      body: Column(
        children: [
          // ✅ نغلف الـ PDF داخل Expanded لتأخذ المساحة المتاحة
          Expanded(
            child: SfPdfViewer.network(
              'https://firebasestorage.googleapis.com/v0/b/miningmarket-firebase.appspot.com/o/pdf%2F5-%D8%A7%D9%84%D8%AA%D8%B9%D8%AF%D9%8A%D9%86-%D9%88%D8%A7%D9%84%D8%B7%D8%A7%D9%82%D8%A9.pdf?alt=media&token=4a0c7527-8e38-4a63-92ed-005e992d555b',
            ),
          ),

          // ✅ الزر في الأسفل خارج الـ Expanded
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // منطق التحميل أو الفتح
              },
              icon: Icon(Icons.download_rounded, size: 24, color: Colors.white),
              label: Text(
                "تحميل المستند",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.color.mainBrown,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                shadowColor: Colors.brown,
              ),
            ),
          )
        ],
      ),
    );
  }
}
