import 'package:flutter/material.dart';

class ResponsiveIphone extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;

  const ResponsiveIphone({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    // iPhone 14 aspect ratio: 390:844 ≈ 1:2.16
    final targetAspectRatio = 844 / 390;

    // Calculate optimal size within constraints
    double width = maxWidth;
    double height = width * targetAspectRatio;

    if (height > maxHeight) {
      height = maxHeight;
      width = height / targetAspectRatio;
    }

    // Calculate bezel (responsive based on device size)
    final bezel = width * 0.026; // ~2.6% of width

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1F),
        borderRadius: BorderRadius.circular(42 * (width / 390)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Screen
          Positioned(
            top: bezel,
            left: bezel,
            right: bezel,
            bottom: bezel,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38 * (width / 390)),
              child: Container(
                color: Colors.white,
                child: _buildScreenContent(width),
              ),
            ),
          ),

          // Dynamic Island / Notch
          Positioned(
            top: bezel - 6,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 200 * (width / 390),
                height: 32 * (width / 390),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20 * (width / 390)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10 * (width / 390),
                      height: 10 * (width / 390),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(5 * (width / 390)),
                      ),
                    ),
                    SizedBox(width: 8 * (width / 390)),
                    Container(
                      width: 10 * (width / 390),
                      height: 10 * (width / 390),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(5 * (width / 390)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Volume up button
          Positioned(
            top: height * 0.18,
            right: -2,
            child: Container(
              width: 3,
              height: 40 * (height / 844),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(2),
                ),
              ),
            ),
          ),

          // Volume down button
          Positioned(
            top: height * 0.25,
            right: -2,
            child: Container(
              width: 3,
              height: 40 * (height / 844),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(2),
                ),
              ),
            ),
          ),

          // Power button
          Positioned(
            top: height * 0.18,
            left: -2,
            child: Container(
              width: 3,
              height: 80 * (height / 844),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(2),
                ),
              ),
            ),
          ),

          // Home indicator
          Positioned(
            bottom: bezel + 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80 * (width / 390),
                height: 5 * (width / 390),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(2.5 * (width / 390)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenContent(double width) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_iphone, size: width * 0.2, color: Colors.blue),
            SizedBox(height: width * 0.06),
            Text(
              'Hello',
              style: TextStyle(
                fontSize: width * 0.12,
                fontWeight: FontWeight.w300,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: width * 0.03),
            Text(
              'iPhone View',
              style: TextStyle(fontSize: width * 0.04, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
