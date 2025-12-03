import 'package:flutter/material.dart';
import 'package:portfolio/screens/about_page.dart';
import 'package:portfolio/screens/contact_page.dart';
import 'package:portfolio/screens/education_page.dart';
import 'package:portfolio/screens/experience_page.dart';
import 'package:portfolio/screens/projects_page.dart';
import 'package:portfolio/screens/skills_page.dart';
import 'package:portfolio/widgets/status_bar_ipad.dart';

import 'package:portfolio/widgets/resume_widgets.dart';

class ResponsiveIpad extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;

  const ResponsiveIpad({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  State<ResponsiveIpad> createState() => _ResponsiveIpadState();
}

class _ResponsiveIpadState extends State<ResponsiveIpad> {
  String? currentApp; // null = home screen

  void openApp(String name) {
    setState(() => currentApp = name);
  }

  void closeApp() {
    setState(() => currentApp = null);
  }

  // ---------------------------
  List<_AppModel> get apps => const [
    _AppModel(Icons.person, 'About', Colors.green),
    _AppModel(Icons.work, 'Experience', Colors.green),
    _AppModel(Icons.book, 'Education', Colors.blue),
    _AppModel(Icons.build, 'Skills', Colors.blue),
    _AppModel(Icons.folder, 'Projects', Colors.orange),
    _AppModel(Icons.contact_mail, 'Contact', Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    final targetAspectRatio = 834 / 1194;

    double width = widget.maxWidth;
    double height = width * targetAspectRatio;

    if (height > widget.maxHeight) {
      height = widget.maxHeight;
      width = height / targetAspectRatio;
    }

    final scale = width / 1194;

    return Container(
      width: width,
      height: height,
      decoration: _outerFrameDecoration(scale),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(16 * scale),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32 * scale),
                child: Stack(
                  children: [
                    // HOME SCREEN
                    _buildInterface(context, width, height, scale),

                    // APP SCREEN
                    if (currentApp != null) _buildAppView(currentApp!, scale),
                  ],
                ),
              ),
            ),
          ),

          _buildCamera(scale),
          _buildVolumeButtons(scale, height),
          _buildPowerButton(scale, height),
          _buildMagneticConnector(scale, width),
        ],
      ),
    );
  }

  // ---------------------------
  BoxDecoration _outerFrameDecoration(double scale) => BoxDecoration(
    color: const Color(0xFF1D1D1F),
    borderRadius: BorderRadius.circular(36 * scale),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.5),
        blurRadius: 50 * scale,
        spreadRadius: 10 * scale,
        offset: Offset(0, 20 * scale),
      ),
    ],
  );

  // ---------------------------
  Widget _buildInterface(
    BuildContext context,
    double width,
    double height,
    double scale,
  ) {
    return Stack(
      children: [
        _buildWallpaper(),
        // ✨ Center text (your name in cursive)
        Center(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFD700), Color(0xFFFFA500), Color(0xFFFF8C00)],
            ).createShader(bounds),
            child: Text(
              "Mr. Kundan Kumar",
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 48 * scale,
                color: Colors.white, // required but ignored by shader
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: StatusBarIpad(width: width, scale: scale),
        ),

        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(
              top: 80 * scale,
              bottom: 120 * scale,
              left: 40 * scale,
              right: 40 * scale,
            ),
            child: _buildAppGrid(scale),
          ),
        ),

        Positioned(
          bottom: 20 * scale,
          left: 0,
          right: 0,
          child: _buildDock(scale),
        ),
      ],
    );
  }

  // ---------------------------
  Widget _buildWallpaper() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('wallpaper/ipad-bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ---------------------------
  Widget _buildDock(double scale) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 240 * scale),
      height: 80 * scale,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24 * scale),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 60 * scale,
        children: apps.map((app) => _DockIcon(app: app, scale: scale)).toList(),
      ),
    );
  }

  // ---------------------------
  Widget _buildAppGrid(double scale) {
    return Column(
      spacing: 20 * scale,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: apps
          .map((app) => _AppGridIcon(app: app, scale: scale))
          .toList(),
    );
  }

  // ---------------------------
  Widget _buildCamera(double scale) {
    return Positioned(
      top: 24 * scale,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 20 * scale,
          height: 20 * scale,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50 * scale),
          ),
          child: Center(
            child: Container(
              width: 10 * scale,
              height: 10 * scale,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(5 * scale),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVolumeButtons(double scale, double height) {
    return Positioned(
      left: 3 * scale,
      top: height * 0.25,
      child: Container(
        width: 3 * scale,
        height: 60 * scale,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(2 * scale),
        ),
      ),
    );
  }

  Widget _buildPowerButton(double scale, double height) {
    return Positioned(
      right: -3 * scale,
      top: height * 0.2,
      child: Container(
        width: 3 * scale,
        height: 80 * scale,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(2 * scale),
        ),
      ),
    );
  }

  Widget _buildMagneticConnector(double scale, double width) {
    return Positioned(
      bottom: 16 * scale,
      left: width / 2 - 150 * scale,
      child: Container(
        width: 300 * scale,
        height: 8 * scale,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(4 * scale),
        ),
      ),
    );
  }

  Widget _buildAppView(String page, double scale) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App top bar (with Back button)
          Container(
            height: 60 * scale,
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: closeApp,
                  child: Icon(
                    Icons.arrow_back,
                    size: 24 * scale,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 12 * scale),
                Text(
                  page,
                  style: TextStyle(
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(child: _buildAppContent(page, scale)),
        ],
      ),
    );
  }

  Widget _buildAppContent(String page, double scale) {
    switch (page) {
      case 'About':
        return AboutPage(scale: scale);
      case 'Experience':
        return ExperiencePage(scale: scale);
      case 'Projects':
        return ProjectsPage(scale: scale);
      case 'Skills':
        return SkillsPage(scale: scale);
      case 'Education':
        return EducationPage(scale: scale);
      case 'Contact':
        return ContactPage(scale: scale);
      default:
        return SizedBox.shrink();
    }
  }
}

// --------------------------------------------------
// REUSABLE APP MODEL
// --------------------------------------------------
class _AppModel {
  final IconData icon;
  final String name;
  final Color color;

  const _AppModel(this.icon, this.name, this.color);
}

// --------------------------------------------------
// REUSABLE DOCK ICON
// --------------------------------------------------
class _DockIcon extends StatelessWidget {
  final _AppModel app;
  final double scale;

  const _DockIcon({required this.app, required this.scale});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .findAncestorStateOfType<_ResponsiveIpadState>()!
          .openApp(app.name),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36 * scale,
            height: 36 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  app.color.withValues(alpha: 0.9),
                  app.color.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(16 * scale),
            ),
            child: Icon(app.icon, color: Colors.white, size: 20 * scale),
          ),
          SizedBox(height: 4 * scale),
          Text(
            app.name,
            style: TextStyle(fontSize: 10 * scale, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// REUSABLE GRID ICON
// --------------------------------------------------
class _AppGridIcon extends StatelessWidget {
  final _AppModel app;
  final double scale;

  const _AppGridIcon({required this.app, required this.scale});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .findAncestorStateOfType<_ResponsiveIpadState>()!
          .openApp(app.name),
      child: Column(
        children: [
          Container(
            width: 56 * scale,
            height: 56 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [app.color, app.color.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(14 * scale),
            ),
            child: Icon(app.icon, color: Colors.white, size: 32 * scale),
          ),
          SizedBox(height: 8 * scale),
          Text(
            app.name,
            style: TextStyle(fontSize: 12 * scale, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
