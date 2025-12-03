import 'package:flutter/material.dart';



class ResumeContact extends StatelessWidget {
  final double scale;
  const ResumeContact({super.key, required this.scale});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24 * scale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contact_mail, size: 64 * scale, color: Colors.pink),
            SizedBox(height: 24 * scale),
            Text(
              "KUNDAN KUMAR",
              style: TextStyle(
                fontSize: 28 * scale,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16 * scale),
            _buildContactRow(Icons.phone, "+91 8083217599"),
            _buildContactRow(Icons.email, "kundankumarcu@gmail.com"),
            _buildContactRow(Icons.code, "github.com/DevZkund"),
            _buildContactRow(Icons.link, "linkedin.com/in/devzkund"),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8 * scale),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20 * scale, color: Colors.grey[700]),
          SizedBox(width: 12 * scale),
          Text(
            text,
            style: TextStyle(fontSize: 16 * scale, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
