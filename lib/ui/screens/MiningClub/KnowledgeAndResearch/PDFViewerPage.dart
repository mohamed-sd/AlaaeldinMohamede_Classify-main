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
              'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
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
