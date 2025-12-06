import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  final double scale;

  const EducationPage({super.key, required this.scale});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _gradientAnimation;

  // Education timeline data
  final List<Education> _educationTimeline = [
    Education(
      institution: 'Chandigarh University, Mohali, Punjab',
      degree: 'Master of Computer Application (MCA)',
      period: 'June 2022 – March 2024',
      gpa: '8.5/10',
      description:
          'Advanced studies in computer applications with focus on software engineering, mobile development, and modern frameworks.',
      achievements: [
        'Specialized in Mobile Application Development',
        'Completed major project in Flutter development',
        'Active participation in coding competitions',
        'Published research paper on cross-platform development',
      ],
      icon: Icons.school,
      color: Color(0xFF00D1FF),
    ),
    Education(
      institution: 'Mirza Ghalib College, Gaya, Bihar',
      degree: 'Bachelor of Computer Application (BCA)',
      period: 'June 2018 – March 2021',
      gpa: '8.0/10',
      description:
          'Foundation in computer science fundamentals, programming languages, and software development methodologies.',
      achievements: [
        'Class Representative for Computer Science Department',
        'Participated in national level coding competitions',
        'Developed multiple academic projects',
        'Active member of coding club',
      ],
      icon: Icons.cast_for_education,
      color: Color(0xFF64FFDA),
    ),
  ];

  // Certifications data
  final List<Certification> _certifications = [
    Certification(
      title: 'Flutter & Figma',
      issuer: 'Google Cloud',
      date: '2023',
      description:
          'Comprehensive course covering Flutter development with Figma UI/UX design principles.',
      credentialId: 'GC-FLUTTER-FIGMA-2023',
      color: Color(0xFF7B61FF),
    ),
    Certification(
      title: 'Core Java',
      issuer: 'Great Learning',
      date: '2022',
      description:
          'In-depth training on Java programming fundamentals, OOP concepts, and advanced features.',
      credentialId: 'GL-JAVA-2022',
      color: Color(0xFFFFD166),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: const Color(0xFF00D1FF).withValues(alpha: 0),
      end: const Color(0xFF7B61FF).withValues(alpha: 0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 500), () {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          final responsiveScale = isSmallScreen
              ? widget.scale * 0.9
              : widget.scale;

          return AnimatedBuilder(
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
                        horizontal: (isSmallScreen ? 20 : 48) * widget.scale,
                        vertical: 40 * widget.scale,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Header Section
                          _buildHeaderSection(responsiveScale),

                          SizedBox(height: 60 * widget.scale),

                          // Education Timeline
                          _buildEducationTimeline(
                            responsiveScale,
                            isSmallScreen,
                          ),

                          SizedBox(height: 60 * widget.scale),

                          // Certifications Section
                          _buildCertificationsSection(
                            responsiveScale,
                            constraints.maxWidth,
                          ),

                          SizedBox(height: 60 * widget.scale),

                          // Academic Stats
                          _buildAcademicStats(responsiveScale),

                          SizedBox(height: 60 * widget.scale),

                          // Skills Gained Section
                          _buildSkillsGainedSection(responsiveScale),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection(double scale) {
    return AnimatedOpacity(
      opacity: _controller.value > 0.2 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 900),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D1FF), Color(0xFF64FFDA), Color(0xFF7B61FF)],
            ).createShader(bounds),
            child: Text(
              'EDUCATION & CERTIFICATIONS',
              style: TextStyle(
                fontSize: 42 * scale,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: const Color(0xFFCCD6F6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16 * widget.scale),
          Container(
            width: 350 * scale,
            height: 3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF00D1FF),
                  Color(0xFF7B61FF),
                  Color(0xFF64FFDA),
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20 * widget.scale),
          Text(
            '6 Years of Academic Excellence • 2 Professional Certifications',
            style: TextStyle(
              fontSize: 20 * scale,
              color: const Color(0xFF8892B0),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTimeline(double scale, bool isSmallScreen) {
    return AnimatedOpacity(
      opacity: _controller.value > 0.3 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1100),
      child: Column(
        children: [
          Text(
            'ACADEMIC JOURNEY',
            style: TextStyle(
              fontSize: 32 * scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40 * widget.scale),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200 * widget.scale),
            child: Column(
              children: List.generate(_educationTimeline.length, (index) {
                return _buildEducationCard(
                  _educationTimeline[index],
                  index,
                  scale,
                  isSmallScreen,
                ); // Fix: passed scale and isSmallScreen
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(
    Education education,
    int index,
    double scale,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40 * widget.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Node
          Column(
            children: [
              Container(
                width: 24 * widget.scale,
                height: 24 * widget.scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      education.color,
                      education.color.withValues(alpha: 0.7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: education.color.withValues(alpha: 0.4),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  education.icon,
                  color: Colors.white,
                  size: 12 * widget.scale,
                ),
              ),
              if (index < _educationTimeline.length - 1)
                Container(
                  width: 2,
                  height: isSmallScreen
                      ? 150 * scale
                      : 100 * widget.scale, // Adjust height for mobile
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        education.color,
                        _educationTimeline[index + 1].color,
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: isSmallScreen ? 16 * scale : 32 * widget.scale),

          // Education Card
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  _showEducationDetails(context, education);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  padding: EdgeInsets.all(
                    isSmallScreen ? 20 * scale : 40 * widget.scale,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF112240).withValues(alpha: 0.9),
                        education.color.withValues(alpha: 0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28 * widget.scale),
                    border: Border.all(
                      color: education.color.withValues(alpha: 0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: education.color.withValues(alpha: 0.2),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isSmallScreen
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  education.degree,
                                  style: TextStyle(
                                    fontSize: 24 * scale,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFCCD6F6),
                                  ),
                                ),
                                SizedBox(height: 8 * scale),
                                Text(
                                  education.institution,
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    color: const Color(0xFF8892B0),
                                  ),
                                ),
                                SizedBox(height: 12 * scale),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16 * scale,
                                    vertical: 8 * scale,
                                  ),
                                  decoration: BoxDecoration(
                                    color: education.color.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      20 * widget.scale,
                                    ),
                                    border: Border.all(
                                      color: education.color.withValues(
                                        alpha: 0.4,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    education.period,
                                    style: TextStyle(
                                      fontSize: 13 * scale,
                                      color: education.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        education.degree,
                                        style: TextStyle(
                                          fontSize: 28 * widget.scale,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFFCCD6F6),
                                        ),
                                      ),
                                      SizedBox(height: 8 * widget.scale),
                                      Text(
                                        education.institution,
                                        style: TextStyle(
                                          fontSize: 18 * widget.scale,
                                          color: const Color(0xFF8892B0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20 * widget.scale,
                                    vertical: 10 * widget.scale,
                                  ),
                                  decoration: BoxDecoration(
                                    color: education.color.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      20 * widget.scale,
                                    ),
                                    border: Border.all(
                                      color: education.color.withValues(
                                        alpha: 0.4,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    education.period,
                                    style: TextStyle(
                                      fontSize: 14 * widget.scale,
                                      color: education.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 24 * widget.scale),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20 * scale,
                              vertical: 10 * scale,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  education.color,
                                  education.color.withValues(alpha: 0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                20 * widget.scale,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grade,
                                  color: Colors.white,
                                  size: 16 * scale,
                                ),
                                SizedBox(width: 8 * scale),
                                Text(
                                  'GPA: ${education.gpa}',
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * widget.scale),
                      Text(
                        education.description,
                        style: TextStyle(
                          fontSize: 16 * scale,
                          color: const Color(0xFF8892B0),
                          height: 1.7,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20 * widget.scale),
                      Wrap(
                        spacing: 12 * widget.scale,
                        runSpacing: 12 * widget.scale,
                        children: education.achievements.take(2).map((
                          achievement,
                        ) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16 * scale,
                              vertical: 8 * scale,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF1E3A5F,
                              ).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(
                                12 * widget.scale,
                              ),
                              border: Border.all(
                                color: education.color.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: education.color,
                                  size: 14 * scale,
                                ),
                                SizedBox(width: 8 * scale),
                                Text(
                                  achievement,
                                  style: TextStyle(
                                    fontSize: 13 * scale,
                                    color: const Color(0xFFCCD6F6),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 24 * widget.scale),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'View Details',
                            style: TextStyle(
                              fontSize: 15 * scale,
                              color: education.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8 * scale),
                          Icon(
                            Icons.arrow_forward,
                            size: 16 * scale,
                            color: education.color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsSection(double scale, double maxWidth) {
    return AnimatedOpacity(
      opacity: _controller.value > 0.6 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1300),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40 * widget.scale),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF112240).withValues(alpha: 0.9),
              const Color(0xFF1E3A5F).withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(28 * widget.scale),
          border: Border.all(
            color: const Color(0xFF64FFDA).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            maxWidth < 700
                ? Column(
                    children: [
                      Text(
                        'PROFESSIONAL CERTIFICATIONS',
                        style: TextStyle(
                          fontSize: 24 * scale,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFCCD6F6),
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16 * scale),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * widget.scale,
                          vertical: 10 * widget.scale,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                          ),
                          borderRadius: BorderRadius.circular(
                            20 * widget.scale,
                          ),
                        ),
                        child: Text(
                          '2 Certifications',
                          style: TextStyle(
                            fontSize: 16 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PROFESSIONAL CERTIFICATIONS',
                        style: TextStyle(
                          fontSize: 28 * widget.scale,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFCCD6F6),
                          letterSpacing: 1.5,
                        ),
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
                          borderRadius: BorderRadius.circular(
                            20 * widget.scale,
                          ),
                        ),
                        child: Text(
                          '2 Certifications',
                          style: TextStyle(
                            fontSize: 16 * widget.scale,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 40 * widget.scale),

            Wrap(
              spacing: 32 * widget.scale,
              runSpacing: 32 * widget.scale,
              alignment: WrapAlignment.center,
              children: _certifications.map((certification) {
                return _buildCertificationCard(certification, scale, maxWidth);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationCard(
    Certification certification,
    double scale,
    double maxWidth,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showCertificationDetails(context, certification);
        },
        child: Container(
          width: maxWidth < 900 ? double.infinity : 400 * widget.scale,
          padding: EdgeInsets.all(32 * widget.scale),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF112240).withValues(alpha: 0.9),
                certification.color.withValues(alpha: 0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(24 * widget.scale),
            border: Border.all(
              color: certification.color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(16 * widget.scale),
                    decoration: BoxDecoration(
                      color: certification.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16 * widget.scale),
                    ),
                    child: Icon(
                      Icons.verified,
                      color: certification.color,
                      size: 32 * scale,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16 * widget.scale,
                      vertical: 8 * widget.scale,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3A5F),
                      borderRadius: BorderRadius.circular(20 * widget.scale),
                    ),
                    child: Text(
                      certification.date,
                      style: TextStyle(
                        fontSize: 14 * scale,
                        color: certification.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24 * widget.scale),
              Text(
                certification.title,
                style: TextStyle(
                  fontSize: 24 * scale,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFCCD6F6),
                ),
              ),
              SizedBox(height: 8 * widget.scale),
              Text(
                'Issued by: ${certification.issuer}',
                style: TextStyle(
                  fontSize: 16 * scale,
                  color: certification.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16 * widget.scale),
              Text(
                certification.description,
                style: TextStyle(
                  fontSize: 15 * scale,
                  color: const Color(0xFF8892B0),
                  height: 1.6,
                ),
              ),
              SizedBox(height: 24 * widget.scale),
              Container(
                padding: EdgeInsets.all(16 * widget.scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A5F).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12 * widget.scale),
                  border: Border.all(
                    color: certification.color.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.fingerprint,
                      color: certification.color,
                      size: 18 * scale,
                    ),
                    SizedBox(width: 12 * widget.scale),
                    Expanded(
                      child: Text(
                        'Credential ID: ${certification.credentialId}',
                        style: TextStyle(
                          fontSize: 13 * scale,
                          color: const Color(0xFFCCD6F6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcademicStats(double scale) {
    return AnimatedOpacity(
      opacity: _controller.value > 0.8 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1500),
      child: Column(
        children: [
          Text(
            'ACADEMIC ACHIEVEMENTS',
            style: TextStyle(
              fontSize: 32 * scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40 * widget.scale),

          Container(
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
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 20 * widget.scale,
              runSpacing: 20 * widget.scale,
              children: [
                _buildStatItem(
                  '6',
                  'Years of Education',
                  Icons.school,
                  const Color(0xFF00D1FF),
                  scale,
                ),
                _buildStatItem(
                  '2',
                  'Degrees Earned',
                  Icons.workspace_premium,
                  const Color(0xFF64FFDA),
                  scale,
                ),
                _buildStatItem(
                  '8.25',
                  'Average GPA',
                  Icons.leaderboard,
                  const Color(0xFF7B61FF),
                  scale,
                ),
                _buildStatItem(
                  '15+',
                  'Academic Projects',
                  Icons.code,
                  const Color(0xFFFFD166),
                  scale,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String value,
    String label,
    IconData icon,
    Color color,
    double scale,
  ) {
    return SizedBox(
      width: 160 * widget.scale,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16 * widget.scale),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32 * scale),
          ),
          SizedBox(height: 16 * widget.scale),
          Text(
            value,
            style: TextStyle(
              fontSize: 36 * scale,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          SizedBox(height: 8 * widget.scale),
          Text(
            label,
            style: TextStyle(
              fontSize: 14 * scale,
              color: const Color(0xFF8892B0),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGainedSection(double scale) {
    return AnimatedOpacity(
      opacity: _controller.value > 0.9 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1700),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40 * widget.scale),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF112240).withValues(alpha: 0.8),
              const Color(0xFF1E3A5F).withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(28 * widget.scale),
          border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
        ),
        child: Column(
          children: [
            Text(
              'SKILLS ACQUIRED THROUGH EDUCATION',
              style: TextStyle(
                fontSize: 28 * scale,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFCCD6F6),
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40 * widget.scale),

            Wrap(
              spacing: 20 * widget.scale,
              runSpacing: 20 * widget.scale,
              alignment: WrapAlignment.center,
              children: [
                _buildAcquiredSkill(
                  'Mobile Development',
                  Icons.mobile_friendly,
                  const Color(0xFF00D1FF),
                  scale,
                ),
                _buildAcquiredSkill(
                  'Software Engineering',
                  Icons.engineering,
                  const Color(0xFF64FFDA),
                  scale,
                ),
                _buildAcquiredSkill(
                  'Database Management',
                  Icons.storage,
                  const Color(0xFF7B61FF),
                  scale,
                ),
                _buildAcquiredSkill(
                  'UI/UX Design',
                  Icons.design_services,
                  const Color(0xFFFFD166),
                  scale,
                ),
                _buildAcquiredSkill(
                  'Algorithms',
                  Icons.psychology,
                  const Color(0xFFEF476F),
                  scale,
                ),
                _buildAcquiredSkill(
                  'Web Technologies',
                  Icons.language,
                  const Color(0xFF06D6A0),
                  scale,
                ),
                _buildAcquiredSkill(
                  'Project Management',
                  Icons.assignment,
                  const Color(0xFF118AB2),
                  scale,
                ),
                _buildAcquiredSkill(
                  'Research Methodology',
                  Icons.science,
                  const Color(0xFF073B4C),
                  scale,
                ),
              ],
            ),

            SizedBox(height: 40 * widget.scale),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32 * widget.scale,
                vertical: 20 * widget.scale,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D1FF), Color(0xFF7B61FF)],
                ),
                borderRadius: BorderRadius.circular(30 * widget.scale),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_stories,
                    color: Colors.white,
                    size: 24 * widget.scale,
                  ),
                  SizedBox(width: 12 * widget.scale),
                  Text(
                    'Lifelong Learner • Continuous Growth',
                    style: TextStyle(
                      fontSize: 20 * widget.scale,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcquiredSkill(
    String skill,
    IconData icon,
    Color color,
    double scale,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24 * scale,
        vertical: 16 * scale,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A5F).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16 * widget.scale),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20 * scale),
          SizedBox(width: 12 * scale),
          Text(
            skill,
            style: TextStyle(
              fontSize: 16 * scale,
              color: const Color(0xFFCCD6F6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showEducationDetails(BuildContext context, Education education) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            final scale = isSmallScreen ? widget.scale * 0.9 : widget.scale;

            return Container(
              margin: EdgeInsets.all(
                isSmallScreen ? 20 * scale : 40 * widget.scale,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFF112240), const Color(0xFF0A192F)],
                ),
                borderRadius: BorderRadius.circular(32 * widget.scale),
                border: Border.all(
                  color: education.color.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: education.color.withValues(alpha: 0.2),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(
                    isSmallScreen ? 24 * scale : 40 * widget.scale,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  education.degree,
                                  style: TextStyle(
                                    fontSize: (isSmallScreen ? 24 : 32) * scale,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFFCCD6F6),
                                  ),
                                ),
                                SizedBox(height: 8 * scale),
                                Text(
                                  education.institution,
                                  style: TextStyle(
                                    fontSize: (isSmallScreen ? 16 : 20) * scale,
                                    color: const Color(0xFF8892B0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: const Color(0xFF8892B0),
                              size: 28 * scale,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24 * scale),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20 * scale,
                              vertical: 10 * scale,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  education.color,
                                  education.color.withValues(alpha: 0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                20 * widget.scale,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 16 * scale,
                                ),
                                SizedBox(width: 8 * scale),
                                Text(
                                  education.period,
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16 * scale),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20 * scale,
                              vertical: 10 * scale,
                            ),
                            decoration: BoxDecoration(
                              color: education.color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(
                                20 * widget.scale,
                              ),
                              border: Border.all(
                                color: education.color.withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grade,
                                  color: education.color,
                                  size: 16 * scale,
                                ),
                                SizedBox(width: 8 * scale),
                                Text(
                                  'GPA: ${education.gpa}',
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    color: education.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32 * scale),
                      Text(
                        education.description,
                        style: TextStyle(
                          fontSize: 18 * scale,
                          color: const Color(0xFFCCD6F6),
                          height: 1.7,
                        ),
                      ),
                      SizedBox(height: 32 * scale),
                      Text(
                        'Key Achievements:',
                        style: TextStyle(
                          fontSize: 24 * scale,
                          fontWeight: FontWeight.w700,
                          color: education.color,
                        ),
                      ),
                      SizedBox(height: 16 * scale),
                      ...education.achievements.map((achievement) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12 * scale),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: education.color,
                                size: 18 * scale,
                              ),
                              SizedBox(width: 12 * scale),
                              Expanded(
                                child: Text(
                                  achievement,
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    color: const Color(0xFFCCD6F6),
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(height: 20 * scale),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCertificationDetails(
    BuildContext context,
    Certification certification,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            final scale = isSmallScreen ? widget.scale * 0.9 : widget.scale;

            return Container(
              margin: EdgeInsets.all(
                isSmallScreen ? 20 * scale : 40 * widget.scale,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFF112240), const Color(0xFF0A192F)],
                ),
                borderRadius: BorderRadius.circular(32 * widget.scale),
                border: Border.all(
                  color: certification.color.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: certification.color.withValues(alpha: 0.2),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(
                    isSmallScreen ? 24 * scale : 40 * widget.scale,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: certification.color,
                                      size: 32 * scale,
                                    ),
                                    SizedBox(width: 16 * scale),
                                    Expanded(
                                      child: Text(
                                        certification.title,
                                        style: TextStyle(
                                          fontSize:
                                              (isSmallScreen ? 24 : 32) * scale,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFFCCD6F6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8 * scale),
                                Text(
                                  'Issued by: ${certification.issuer}',
                                  style: TextStyle(
                                    fontSize: (isSmallScreen ? 16 : 20) * scale,
                                    color: certification.color,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              color: const Color(0xFF8892B0),
                              size: 28 * scale,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24 * scale),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * scale,
                          vertical: 10 * scale,
                        ),
                        decoration: BoxDecoration(
                          color: certification.color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                            20 * widget.scale,
                          ),
                          border: Border.all(
                            color: certification.color.withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: certification.color,
                              size: 16 * scale,
                            ),
                            SizedBox(width: 8 * scale),
                            Text(
                              'Issued: ${certification.date}',
                              style: TextStyle(
                                fontSize: 16 * scale,
                                color: certification.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32 * scale),
                      Text(
                        certification.description,
                        style: TextStyle(
                          fontSize: 18 * scale,
                          color: const Color(0xFFCCD6F6),
                          height: 1.7,
                        ),
                      ),
                      SizedBox(height: 32 * scale),
                      Container(
                        padding: EdgeInsets.all(20 * scale),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A5F).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(
                            16 * widget.scale,
                          ),
                          border: Border.all(
                            color: certification.color.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Credential Information',
                              style: TextStyle(
                                fontSize: 20 * scale,
                                fontWeight: FontWeight.w700,
                                color: certification.color,
                              ),
                            ),
                            SizedBox(height: 12 * scale),
                            Row(
                              children: [
                                Icon(
                                  Icons.fingerprint,
                                  color: certification.color,
                                  size: 20 * scale,
                                ),
                                SizedBox(width: 12 * scale),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Credential ID:',
                                        style: TextStyle(
                                          fontSize: 14 * scale,
                                          color: const Color(0xFF8892B0),
                                        ),
                                      ),
                                      SizedBox(height: 4 * scale),
                                      Text(
                                        certification.credentialId,
                                        style: TextStyle(
                                          fontSize: 16 * scale,
                                          color: const Color(0xFFCCD6F6),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20 * scale),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Education {
  final String institution;
  final String degree;
  final String period;
  final String gpa;
  final String description;
  final List<String> achievements;
  final IconData icon;
  final Color color;

  Education({
    required this.institution,
    required this.degree,
    required this.period,
    required this.gpa,
    required this.description,
    required this.achievements,
    required this.icon,
    required this.color,
  });
}

class Certification {
  final String title;
  final String issuer;
  final String date;
  final String description;
  final String credentialId;
  final Color color;

  Certification({
    required this.title,
    required this.issuer,
    required this.date,
    required this.description,
    required this.credentialId,
    required this.color,
  });
}
