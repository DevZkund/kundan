import 'package:flutter/material.dart';
import 'package:portfolio/widgets/ipad_device.dart';
import 'package:portfolio/widgets/iphone_device.dart';

class MyHomePage extends StatelessWidget {
  final double scale;
  const MyHomePage({super.key, required this.scale});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Responsive logic: Use iPad for width > 600, iPhone otherwise
        final isTablet = screenWidth > 600;

        return Center(
          child: isTablet
              ? ResponsiveIpad(
                  maxWidth: screenWidth * 0.72 * scale,
                  maxHeight: screenHeight * 0.72 * scale,
                )
              : ResponsiveIphone(
                  maxWidth: screenWidth * 0.84 * scale,
                  maxHeight: screenHeight * 0.82 * scale,
                ),
        );
      },
    );
  }
}
