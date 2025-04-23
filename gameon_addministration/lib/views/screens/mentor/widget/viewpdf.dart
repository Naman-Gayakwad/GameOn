import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FirebasePDFViewer extends StatelessWidget {
  final String pdfUrl;

  const FirebasePDFViewer({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Certificate")),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
