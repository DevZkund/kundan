import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final double scale;

  const AboutPage({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          "About",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "About Page Content Here",
          style: TextStyle(
            fontSize: 18 * scale,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
