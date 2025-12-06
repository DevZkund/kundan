import 'package:flutter/material.dart';
import 'package:portfolio/screens/about_page.dart';
import 'package:portfolio/screens/contact_page.dart';
import 'package:portfolio/screens/education_page.dart';
import 'package:portfolio/screens/experience_page.dart';
import 'package:portfolio/screens/projects_page.dart';
import 'package:portfolio/screens/skills_page.dart';

class ResponsiveIphone extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;

  const ResponsiveIphone({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  State<ResponsiveIphone> createState() => _ResponsiveIphoneState();
}

class _ResponsiveIphoneState extends State<ResponsiveIphone> {
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
    _AppModel(Icons.folder, 'Projects', Colors.orange),
    _AppModel(Icons.build, 'Skills', Colors.blue),
    _AppModel(Icons.school, 'Education', Colors.blue),
    _AppModel(Icons.contact_mail, 'Contact', Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    // iPhone 14 aspect ratio: 390:844 ≈ 1:2.16
    final targetAspectRatio = 390 / 844;

    double width = widget.maxWidth;
    double height = width / targetAspectRatio;

    if (height > widget.maxHeight) {
      height = widget.maxHeight;
      width = height * targetAspectRatio;
    }

    final scale = width / 390;
    // Calculate bezel (responsive based on device size)
    final bezel = width * 0.035; // ~3.5% of width

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1F),
        borderRadius: BorderRadius.circular(50 * scale),
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
              borderRadius: BorderRadius.circular(46 * scale),
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

          // Dynamic Island / Notch
          Positioned(
            top: bezel + 10 * scale,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120 * scale,
                height: 35 * scale,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20 * scale),
                ),
              ),
            ),
          ),

          // Volume up button
          Positioned(
            top: height * 0.18,
            left: -2,
            child: Container(
              width: 3,
              height: 40 * scale,
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
            left: -2,
            child: Container(
              width: 3,
              height: 40 * scale,
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
            top: height * 0.2,
            right: -2,
            child: Container(
              width: 3,
              height: 60 * scale,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(2),
                ),
              ),
            ),
          ),

          // Home indicator (visual handle)
          Positioned(
            bottom: bezel + 8 * scale,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 130 * scale,
                height: 5 * scale,
                decoration: BoxDecoration(
                  color: currentApp == null
                      ? Colors.white.withValues(alpha: 0.5)
                      : Colors.black.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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

        // Status Bar (Simplified)
        Positioned(
          top: 15 * scale,
          left: 20 * scale,
          right: 20 * scale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "9:41",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.signal_cellular_alt,
                    color: Colors.white,
                    size: 16 * scale,
                  ),
                  SizedBox(width: 5 * scale),
                  Icon(Icons.wifi, color: Colors.white, size: 16 * scale),
                  SizedBox(width: 5 * scale),
                  Icon(
                    Icons.battery_full,
                    color: Colors.white,
                    size: 16 * scale,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Center text (your name in cursive)
        Positioned(
          top: height * 0.15,
          left: 0,
          right: 0,
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFFFFA500),
                    Color(0xFFFF8C00),
                  ],
                ).createShader(bounds),
                child: Text(
                  "Kundan",
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 42 * scale,
                    color: Colors.white, // required but ignored by shader
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "Kumar",
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 42 * scale,
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),

        // App Grid
        Positioned(
          top: height * 0.4,
          left: 20 * scale,
          right: 20 * scale,
          bottom: 100 * scale,
          child: _buildAppGrid(scale),
        ),

        // Dock
        Positioned(
          bottom: 30 * scale,
          left: 20 * scale,
          right: 20 * scale,
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
          image: AssetImage(
            'assets/wallpaper/iphone-bg.jpg',
          ), // Assuming asset exists or using color fallback
          fit: BoxFit.cover,
        ),
        color: Color(0xFF1E3A5F), // Fallback color
      ),
    );
  }

  // ---------------------------
  Widget _buildDock(double scale) {
    return Container(
      height: 85 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(28 * scale),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: apps
            .take(4)
            .map((app) => _DockIcon(app: app, scale: scale))
            .toList(),
      ),
    );
  }

  // ---------------------------
  Widget _buildAppGrid(double scale) {
    // Show remaining apps in grid if any
    final gridApps = apps.skip(4).toList();
    if (gridApps.isEmpty) return SizedBox.shrink();

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16 * scale,
        mainAxisSpacing: 16 * scale,
      ),
      itemCount: gridApps.length,
      itemBuilder: (context, index) {
        return _AppGridIcon(app: gridApps[index], scale: scale);
      },
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
            height: 50 * scale + 35 * scale, // + dynamic island area
            padding: EdgeInsets.only(
              top: 35 * scale,
              left: 16 * scale,
              right: 16 * scale,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: closeApp,
                  child: Container(
                    padding: EdgeInsets.all(8 * scale),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20 * scale,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  page,
                  style: TextStyle(
                    fontSize: 18 * scale,
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
      case 'Projects': // Updated name to match typical mobile label
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
          .findAncestorStateOfType<_ResponsiveIphoneState>()!
          .openApp(app.name),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50 * scale,
            height: 50 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [app.color, app.color.withValues(alpha: 0.8)],
              ),
              borderRadius: BorderRadius.circular(14 * scale),
              boxShadow: [
                BoxShadow(
                  color: app.color.withValues(alpha: 0.3),
                  blurRadius: 8 * scale,
                  offset: Offset(0, 4 * scale),
                ),
              ],
            ),
            child: Icon(app.icon, color: Colors.white, size: 28 * scale),
          ),
          // No text in dock for iPhone usually, or very small
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
          .findAncestorStateOfType<_ResponsiveIphoneState>()!
          .openApp(app.name),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54 * scale,
            height: 54 * scale,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [app.color, app.color.withValues(alpha: 0.8)],
              ),
              borderRadius: BorderRadius.circular(14 * scale),
              boxShadow: [
                BoxShadow(
                  color: app.color.withValues(alpha: 0.3),
                  blurRadius: 8 * scale,
                  offset: Offset(0, 4 * scale),
                ),
              ],
            ),
            child: Icon(app.icon, color: Colors.white, size: 30 * scale),
          ),
          SizedBox(height: 6 * scale),
          Text(
            app.name,
            style: TextStyle(
              fontSize: 11 * scale,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
