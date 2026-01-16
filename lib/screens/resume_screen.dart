import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume'),
        backgroundColor: const Color(0xFF0F1B2D),
        foregroundColor: Colors.white,
      ),
      body: PdfViewer.asset('assets/Kundan_resume_02.pdf'),
    );
  }
}
