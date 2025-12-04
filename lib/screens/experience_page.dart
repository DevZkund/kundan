import 'package:flutter/material.dart';

class ExperiencePage extends StatefulWidget {
  final double scale;

  const ExperiencePage({super.key, required this.scale});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: const Color(0xFF00D1FF).withValues(alpha: 0.1),
      end: const Color(0xFF7B61FF).withValues(alpha: 0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 400), () {
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
      backgroundColor: const Color(0xFF0A192F),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(_slideAnimation.value, 0),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 48 * widget.scale,
                  vertical: 40 * widget.scale,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header Section
                    _buildHeaderSection(),

                    SizedBox(height: 60 * widget.scale),

                    // Main Experience Timeline
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1200 * widget.scale,
                      ),
                      child: Column(
                        children: [
                          // Current Experience Card (Highlighted)
                          _buildCurrentExperienceCard(),

                          SizedBox(height: 40 * widget.scale),

                          Container(
                            width: 4,
                            height: 40 * widget.scale,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF00D1FF), Color(0xFF7B61FF)],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40 * widget.scale),

                    // Technologies Section
                    _buildTechnologiesSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.2 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
            ).createShader(bounds),
            child: Text(
              'WORK EXPERIENCE',
              style: TextStyle(
                fontSize: 42 * widget.scale,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: const Color(0xFF64FFDA),
              ),
            ),
          ),
          SizedBox(height: 16 * widget.scale),
          Container(
            width: 200 * widget.scale,
            height: 3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20 * widget.scale),
          Text(
            '1.5+ Years of Professional Experience',
            style: TextStyle(
              fontSize: 20 * widget.scale,
              color: const Color(0xFF8892B0),
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentExperienceCard() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.3 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 900),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(40 * widget.scale),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF112240).withValues(alpha: 0.9),
                _gradientAnimation.value!,
              ],
            ),
            borderRadius: BorderRadius.circular(28 * widget.scale),
            border: Border.all(
              color: const Color(0xFF00D1FF).withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D1FF).withValues(alpha: 0.2),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.work_outline,
                            color: const Color(0xFF64FFDA),
                            size: 28 * widget.scale,
                          ),
                          SizedBox(width: 12 * widget.scale),
                          Text(
                            'Flutter Developer',
                            style: TextStyle(
                              fontSize: 28 * widget.scale,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFCCD6F6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8 * widget.scale),
                      Text(
                        'Infutrix Technologies Pvt. Ltd., Mohali',
                        style: TextStyle(
                          fontSize: 18 * widget.scale,
                          color: const Color(0xFF8892B0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * widget.scale,
                      vertical: 10 * widget.scale,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                      ),
                      borderRadius: BorderRadius.circular(20 * widget.scale),
                    ),
                    child: Text(
                      'Present',
                      style: TextStyle(
                        fontSize: 16 * widget.scale,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30 * widget.scale),
              Text(
                'March 2024 – Present',
                style: TextStyle(
                  fontSize: 18 * widget.scale,
                  color: const Color(0xFF64FFDA),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24 * widget.scale),
              _buildExperiencePoint(
                'Developed and maintained multiple production-ready mobile applications using Flutter, Dart, and modern state management architectures.',
              ),
              SizedBox(height: 16 * widget.scale),
              _buildExperiencePoint(
                'Collaborated closely with backend teams to integrate REST APIs, optimize performance, and ensure seamless user experience.',
              ),
              SizedBox(height: 16 * widget.scale),
              _buildExperiencePoint(
                'Implemented secure authentication, push notifications, payment integration, and responsive UI across diverse mobile platforms.',
              ),
              SizedBox(height: 16 * widget.scale),
              _buildExperiencePoint(
                'Built modular and scalable codebases using GetX, BLoC (Cubit), and Riverpod for efficient state management.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperiencePoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8 * widget.scale),
          width: 8 * widget.scale,
          height: 8 * widget.scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
            ),
          ),
        ),
        SizedBox(width: 16 * widget.scale),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17 * widget.scale,
              height: 1.6,
              color: const Color(0xFFCCD6F6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnologiesSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.7 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1300),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 1200 * widget.scale),
        padding: EdgeInsets.all(40 * widget.scale),
        decoration: BoxDecoration(
          color: const Color(0xFF112240).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(28 * widget.scale),
          border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
              ).createShader(bounds),
              child: Text(
                'TECHNOLOGIES & SKILLS',
                style: TextStyle(
                  fontSize: 32 * widget.scale,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: const Color(0xFF64FFDA),
                ),
              ),
            ),
            SizedBox(height: 40 * widget.scale),

            // Technology Grid
            Wrap(
              spacing: 24 * widget.scale,
              runSpacing: 24 * widget.scale,
              alignment: WrapAlignment.center,
              children: [
                _buildTechChip('Flutter SDK', Icons.mobile_friendly),
                _buildTechChip('Dart', Icons.code),
                _buildTechChip('GetX', Icons.architecture),
                _buildTechChip('BLoC/Cubit', Icons.view_quilt),
                _buildTechChip('Riverpod', Icons.settings_input_component),
                _buildTechChip('REST APIs', Icons.api),
                _buildTechChip('Firebase', Icons.cloud),
                _buildTechChip('Git/GitHub', Icons.gite),
                _buildTechChip('Android Studio', Icons.android),
                _buildTechChip('VS Code', Icons.edit),
                _buildTechChip('React Native', Icons.devices),
                _buildTechChip('JavaScript', Icons.javascript),
              ],
            ),

            SizedBox(height: 40 * widget.scale),

            // Methodologies
            Wrap(
              spacing: 16 * widget.scale,
              runSpacing: 16 * widget.scale,
              alignment: WrapAlignment.center,
              children: [
                _buildMethodologyChip('Agile Development'),
                _buildMethodologyChip('Clean Architecture'),
                _buildMethodologyChip('State Management'),
                _buildMethodologyChip('Cross-platform'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech, IconData icon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: EdgeInsets.symmetric(
        horizontal: 24 * widget.scale,
        vertical: 16 * widget.scale,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E3A5F).withValues(alpha: 0.8),
            const Color(0xFF112240).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(16 * widget.scale),
        border: Border.all(color: const Color(0xFF2D4A76), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF64FFDA), size: 20 * widget.scale),
          SizedBox(width: 12 * widget.scale),
          Text(
            tech,
            style: TextStyle(
              fontSize: 16 * widget.scale,
              color: const Color(0xFFCCD6F6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodologyChip(String methodology) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * widget.scale,
        vertical: 12 * widget.scale,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF00D1FF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30 * widget.scale),
        border: Border.all(
          color: const Color(0xFF00D1FF).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        methodology,
        style: TextStyle(
          fontSize: 14 * widget.scale,
          color: const Color(0xFF64FFDA),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
