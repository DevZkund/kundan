import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  final double scale;

  const AboutPage({super.key, required this.scale});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Start animation after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F), // Navy blue background
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 48 * widget.scale,
                    vertical: 32 * widget.scale,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header with animated profile section
                      _buildAnimatedProfileSection(),

                      SizedBox(height: 48 * widget.scale),

                      // About Me Content in Two Columns for Tablet
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 1200 * widget.scale,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column - About Text
                            Expanded(flex: 3, child: _buildAboutSection()),

                            SizedBox(width: 48 * widget.scale),

                            // Right Column - Contact & Facts
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildSkillsSection(),
                                  SizedBox(height: 32 * widget.scale),
                                  _buildContactSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedProfileSection() {
    return Column(
      children: [
        // Animated profile circle with gradient
        Container(
          width: 220 * widget.scale,
          height: 220 * widget.scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF00D1FF), // Cyan
                Color(0xFF7B61FF), // Purple
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D1FF).withValues(alpha: 0.3),
                blurRadius: 40 * widget.scale,
                spreadRadius: 10 * widget.scale,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 200 * widget.scale,
              height: 200 * widget.scale,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0A192F),
              ),
              child: const Icon(
                Icons.person,
                size: 80,
                color: Color(0xFF64FFDA), // Mint green
              ),
              // Replace with your image:
              // child: ClipOval(
              //   child: Image.asset('assets/profile.jpg', fit: BoxFit.cover),
              // ),
            ),
          ),
        ),

        SizedBox(height: 32 * widget.scale),

        // Name with typing animation effect
        AnimatedOpacity(
          opacity: _controller.value > 0.4 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                ).createShader(bounds),
                child: Text(
                  'KUNDAN KUMAR',
                  style: TextStyle(
                    fontSize: 42 * widget.scale,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: const Color(0xFF64FFDA),
                  ),
                ),
              ),
              SizedBox(height: 8 * widget.scale),
              Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: 24 * widget.scale,
                  color: const Color(0xFFCCD6F6),
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 4 * widget.scale),
              Container(
                width: 200 * widget.scale,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.5 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: EdgeInsets.all(32 * widget.scale),
        decoration: BoxDecoration(
          color: const Color(0xFF112240).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24 * widget.scale),
          border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  color: const Color(0xFF64FFDA),
                  size: 28 * widget.scale,
                ),
                SizedBox(width: 12 * widget.scale),
                Text(
                  'ABOUT ME',
                  style: TextStyle(
                    fontSize: 28 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFCCD6F6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24 * widget.scale),
            Text(
              'I am a passionate and results-oriented Flutter Developer with over 1.5 years of experience in creating high-performance cross-platform applications for Android and iOS.',
              style: TextStyle(
                fontSize: 18 * widget.scale,
                height: 1.8,
                color: const Color(0xFF8892B0),
              ),
            ),
            SizedBox(height: 16 * widget.scale),
            Text(
              'My expertise lies in building responsive, intuitive user interfaces and integrating RESTful APIs to deliver seamless user experiences. I specialize in modern Flutter architectures including GetX and BLoC (Cubit), and I am committed to writing clean, maintainable code.',
              style: TextStyle(
                fontSize: 18 * widget.scale,
                height: 1.8,
                color: const Color(0xFF8892B0),
              ),
            ),
            SizedBox(height: 16 * widget.scale),
            Text(
              'I enjoy collaborating with teams to transform ideas into scalable, business-aligned software solutions. When I\'m not coding, I love exploring new technologies and contributing to open-source projects.',
              style: TextStyle(
                fontSize: 18 * widget.scale,
                height: 1.8,
                color: const Color(0xFF8892B0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.6 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 700),
      child: Container(
        padding: EdgeInsets.all(32 * widget.scale),
        decoration: BoxDecoration(
          color: const Color(0xFF112240).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24 * widget.scale),
          border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.contact_page_outlined,
                  color: const Color(0xFF64FFDA),
                  size: 28 * widget.scale,
                ),
                SizedBox(width: 12 * widget.scale),
                Text(
                  'CONTACT',
                  style: TextStyle(
                    fontSize: 24 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFCCD6F6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20 * widget.scale),
            _buildContactItem(Icons.phone_iphone, '+91 8083217599'),
            SizedBox(height: 16 * widget.scale),
            _buildContactItem(Icons.alternate_email, 'kundankumarcu@gmail.com'),
            SizedBox(height: 16 * widget.scale),
            _buildContactItem(Icons.code, 'github.com/DevZkund'),
            SizedBox(height: 16 * widget.scale),
            _buildContactItem(Icons.linked_camera, 'linkedin.com/in/devzkund'),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.7 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: EdgeInsets.all(32 * widget.scale),
        decoration: BoxDecoration(
          color: const Color(0xFF112240).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24 * widget.scale),
          border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_outline,
                  color: const Color(0xFF64FFDA),
                  size: 28 * widget.scale,
                ),
                SizedBox(width: 12 * widget.scale),
                Text(
                  'EXPERTISE',
                  style: TextStyle(
                    fontSize: 24 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFCCD6F6),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20 * widget.scale),
            _buildSkillItem('Flutter Development', 90),
            SizedBox(height: 16 * widget.scale),
            _buildSkillItem('Cross-Platform Apps', 85),
            SizedBox(height: 16 * widget.scale),
            _buildSkillItem('UI/UX Design', 80),
            SizedBox(height: 16 * widget.scale),
            _buildSkillItem('API Integration', 95),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(16 * widget.scale),
        decoration: BoxDecoration(
          color: const Color(0xFF1E3A5F).withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12 * widget.scale),
          border: Border.all(color: const Color(0xFF2D4A76), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF64FFDA), size: 20 * widget.scale),
            SizedBox(width: 16 * widget.scale),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16 * widget.scale,
                  color: const Color(0xFFCCD6F6),
                ),
              ),
            ),
            Icon(
              Icons.contacts,
              size: 16 * widget.scale,
              color: const Color(0xFF8892B0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillItem(String skill, int percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: TextStyle(
                fontSize: 16 * widget.scale,
                color: const Color(0xFFCCD6F6),
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 14 * widget.scale,
                color: const Color(0xFF64FFDA),
              ),
            ),
          ],
        ),
        SizedBox(height: 8 * widget.scale),
        Container(
          height: 6 * widget.scale,
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A5F),
            borderRadius: BorderRadius.circular(3 * widget.scale),
          ),
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutQuart,
            widthFactor: _controller.value > 0.8 ? percentage / 100 : 0.0,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                ),
                borderRadius: BorderRadius.circular(3 * widget.scale),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
