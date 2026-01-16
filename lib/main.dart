import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:portfolio/screens/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  pdfrxFlutterInitialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kundan Kumar | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const LandingPage(scale: 1),
    );
  }
}
