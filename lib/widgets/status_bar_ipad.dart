import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusBarIpad extends StatefulWidget {
  final double width;
  final double scale;

  const StatusBarIpad({super.key, required this.width, required this.scale});

  @override
  State<StatusBarIpad> createState() => _StatusBarIpadState();
}

class _StatusBarIpadState extends State<StatusBarIpad> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {}); // forces rebuild → updates time
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget buildStatusBar(double width, double scale) {
    final now = DateTime.now();
    final time = DateFormat.Hms().format(now);

    return Container(
      height: 44 * scale,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24 * scale),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side
            Row(
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 16 * scale),
                Icon(
                  Icons.location_on,
                  size: 16 * scale,
                  color: Colors.black87,
                ),
                SizedBox(width: 8 * scale),
                Text(
                  'Home',
                  style: TextStyle(fontSize: 12 * scale, color: Colors.black87),
                ),
              ],
            ),

            Row(
              children: [
                Icon(Icons.wifi, size: 16 * scale, color: Colors.black87),
                SizedBox(width: 12 * scale),
                Icon(
                  Icons.battery_full,
                  size: 20 * scale,
                  color: Colors.black87,
                ),
                SizedBox(width: 12 * scale),
                Container(
                  width: 24 * scale,
                  height: 24 * scale,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Right side
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildStatusBar(widget.width, widget.scale);
  }
}
