import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  final double scale;

  const SkillsPage({super.key, required this.scale});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _gradientAnimation;

  // Skill categories with detailed information
  final List<SkillCategory> _skillCategories = [
    SkillCategory(
      title: 'Programming Languages',
      icon: Icons.code,
      color: Color(0xFF00D1FF),
      skills: [
        Skill(
          name: 'Dart',
          level: 95,
          description: 'Primary language for Flutter development',
        ),
        Skill(
          name: 'JavaScript',
          level: 80,
          description: 'Web development and React Native',
        ),
      ],
    ),
    SkillCategory(
      title: 'Flutter Framework',
      icon: Icons.mobile_friendly,
      color: Color(0xFF64FFDA),
      skills: [
        Skill(
          name: 'Flutter SDK',
          level: 92,
          description: 'Cross-platform mobile development',
        ),
        Skill(
          name: 'GetX',
          level: 88,
          description: 'State management & navigation',
        ),
        Skill(
          name: 'BLoC/Cubit',
          level: 85,
          description: 'Business logic component pattern',
        ),
        Skill(
          name: 'Riverpod',
          level: 82,
          description: 'Provider-based state management',
        ),
      ],
    ),
    SkillCategory(
      title: 'Backend & APIs',
      icon: Icons.api,
      color: Color(0xFF7B61FF),
      skills: [
        Skill(
          name: 'REST APIs',
          level: 90,
          description: 'API integration & consumption',
        ),
        Skill(
          name: 'Firebase',
          level: 85,
          description: 'Authentication, Firestore, Cloud Messaging',
        ),
        Skill(
          name: 'JSON',
          level: 95,
          description: 'Data serialization & parsing',
        ),
      ],
    ),
    SkillCategory(
      title: 'Development Tools',
      icon: Icons.build,
      color: Color(0xFFFFD166),
      skills: [
        Skill(
          name: 'Git/GitHub',
          level: 88,
          description: 'Version control & collaboration',
        ),
        Skill(
          name: 'Android Studio',
          level: 85,
          description: 'Primary IDE for Flutter',
        ),
        Skill(
          name: 'VS Code',
          level: 90,
          description: 'Lightweight code editor',
        ),
        Skill(
          name: 'Postman',
          level: 80,
          description: 'API testing & development',
        ),
      ],
    ),
    SkillCategory(
      title: 'Methodologies',
      icon: Icons.architecture,
      color: Color(0xFFEF476F),
      skills: [
        Skill(
          name: 'Agile Development',
          level: 85,
          description: 'Scrum & iterative development',
        ),
        Skill(
          name: 'Clean Architecture',
          level: 82,
          description: 'Structured code organization',
        ),
        Skill(
          name: 'State Management',
          level: 90,
          description: 'Various state management patterns',
        ),
      ],
    ),
    SkillCategory(
      title: 'Platforms',
      icon: Icons.devices,
      color: Color(0xFF06D6A0),
      skills: [
        Skill(
          name: 'Android',
          level: 92,
          description: 'Native Android development',
        ),
        Skill(name: 'iOS', level: 85, description: 'Native iOS development'),
        Skill(
          name: 'Cross-platform',
          level: 95,
          description: 'Single codebase deployment',
        ),
      ],
    ),
  ];

  final List<SkillExperience> _skillExperiences = [
    SkillExperience(
      skill: 'Flutter Development',
      years: 1.5,
      projects: 8,
      proficiency: 'Expert',
    ),
    SkillExperience(
      skill: 'Cross-Platform Apps',
      years: 1.5,
      projects: 8,
      proficiency: 'Advanced',
    ),
    SkillExperience(
      skill: 'UI/UX Design',
      years: 1.5,
      projects: 8,
      proficiency: 'Advanced',
    ),
    SkillExperience(
      skill: 'API Integration',
      years: 1.5,
      projects: 8,
      proficiency: 'Expert',
    ),
    SkillExperience(
      skill: 'State Management',
      years: 1.5,
      projects: 8,
      proficiency: 'Advanced',
    ),
    SkillExperience(
      skill: 'Firebase',
      years: 1.0,
      projects: 4,
      proficiency: 'Intermediate',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: -5, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: const Color(0xFF00D1FF).withValues(alpha: 0),
      end: const Color(0xFF7B61FF).withValues(alpha: 0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 600), () {
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
            child: Transform(
              transform: Matrix4.identity()
                ..scale(_scaleAnimation.value)
                ..rotateZ(_rotationAnimation.value * 3.1415927 / 180),
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

                    // Skills Overview
                    _buildSkillsOverview(),

                    SizedBox(height: 60 * widget.scale),

                    // Skills Categories Grid
                    _buildSkillsGrid(),

                    SizedBox(height: 60 * widget.scale),

                    // Experience Timeline
                    _buildExperienceSection(),

                    SizedBox(height: 60 * widget.scale),

                    // Skill Progression
                    _buildProgressionSection(),
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
      duration: const Duration(milliseconds: 1000),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D1FF), Color(0xFF64FFDA), Color(0xFF7B61FF)],
            ).createShader(bounds),
            child: Text(
              'TECHNICAL SKILLS',
              style: TextStyle(
                fontSize: 42 * widget.scale,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: const Color(0xFFCCD6F6),
              ),
            ),
          ),
          SizedBox(height: 16 * widget.scale),
          Container(
            width: 250 * widget.scale,
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
            '1.5+ Years of Technical Excellence',
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

  Widget _buildSkillsOverview() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.3 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1200),
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
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left - Main Skills
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Core Expertise',
                    style: TextStyle(
                      fontSize: 28 * widget.scale,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFCCD6F6),
                    ),
                  ),
                  SizedBox(height: 24 * widget.scale),
                  _buildSkillChip('Flutter SDK', 95, const Color(0xFF64FFDA)),
                  SizedBox(height: 16 * widget.scale),
                  _buildSkillChip(
                    'Dart Programming',
                    95,
                    const Color(0xFF00D1FF),
                  ),
                  SizedBox(height: 16 * widget.scale),
                  _buildSkillChip(
                    'Cross-Platform',
                    92,
                    const Color(0xFF7B61FF),
                  ),
                  SizedBox(height: 16 * widget.scale),
                  _buildSkillChip('UI/UX Design', 88, const Color(0xFFFFD166)),
                ],
              ),
            ),

            SizedBox(width: 40 * widget.scale),

            // Right - Stats
            Container(
              width: 300 * widget.scale,
              padding: EdgeInsets.all(32 * widget.scale),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A5F).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24 * widget.scale),
                border: Border.all(color: const Color(0xFF2D4A76), width: 1),
              ),
              child: Column(
                children: [
                  _buildStatCircle('15+', 'Skills', const Color(0xFF00D1FF)),
                  SizedBox(height: 24 * widget.scale),
                  _buildStatCircle('8', 'Projects', const Color(0xFF64FFDA)),
                  SizedBox(height: 24 * widget.scale),
                  _buildStatCircle('1.5+', 'Years', const Color(0xFF7B61FF)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: TextStyle(
                fontSize: 18 * widget.scale,
                color: const Color(0xFFCCD6F6),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 16 * widget.scale,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8 * widget.scale),
        Container(
          height: 10 * widget.scale,
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A5F),
            borderRadius: BorderRadius.circular(5 * widget.scale),
          ),
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeOutQuart,
            widthFactor: _controller.value > 0.4 ? percentage / 100 : 0.0,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(5 * widget.scale),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCircle(String value, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 120 * widget.scale,
          height: 120 * widget.scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withValues(alpha: 0.7)],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 32 * widget.scale,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        SizedBox(height: 12 * widget.scale),
        Text(
          label,
          style: TextStyle(
            fontSize: 16 * widget.scale,
            color: const Color(0xFF8892B0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsGrid() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.5 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1400),
      child: Column(
        children: [
          Text(
            'SKILLS CATEGORIES',
            style: TextStyle(
              fontSize: 32 * widget.scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 40 * widget.scale),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 3 : 2,
              crossAxisSpacing: 32 * widget.scale,
              mainAxisSpacing: 32 * widget.scale,
              childAspectRatio: 1.2,
            ),
            itemCount: _skillCategories.length,
            itemBuilder: (context, index) {
              return _buildSkillCategoryCard(_skillCategories[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategoryCard(SkillCategory category, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showSkillDetails(context, category);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF112240).withValues(alpha: 0.9),
                category.color.withValues(alpha: 0.15),
              ],
            ),
            borderRadius: BorderRadius.circular(24 * widget.scale),
            border: Border.all(
              color: category.color.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20 * widget.scale,
                right: 20 * widget.scale,
                child: Icon(
                  category.icon,
                  size: 40 * widget.scale,
                  color: category.color.withValues(alpha: 0.3),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32 * widget.scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      category.icon,
                      size: 32 * widget.scale,
                      color: category.color,
                    ),
                    SizedBox(height: 20 * widget.scale),
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 20 * widget.scale,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFCCD6F6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16 * widget.scale),
                    ...category.skills.take(2).map((skill) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8 * widget.scale),
                        child: Row(
                          children: [
                            Container(
                              width: 6 * widget.scale,
                              height: 6 * widget.scale,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: category.color,
                              ),
                            ),
                            SizedBox(width: 12 * widget.scale),
                            Expanded(
                              child: Text(
                                skill.name,
                                style: TextStyle(
                                  fontSize: 14 * widget.scale,
                                  color: const Color(0xFF8892B0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (category.skills.length > 2)
                      Padding(
                        padding: EdgeInsets.only(top: 8 * widget.scale),
                        child: Text(
                          '+${category.skills.length - 2} more',
                          style: TextStyle(
                            fontSize: 13 * widget.scale,
                            color: category.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 13 * widget.scale,
                            color: category.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8 * widget.scale),
                        Icon(
                          Icons.arrow_forward,
                          size: 14 * widget.scale,
                          color: category.color,
                        ),
                      ],
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

  Widget _buildExperienceSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.7 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1600),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SKILL EXPERIENCE',
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
                    borderRadius: BorderRadius.circular(20 * widget.scale),
                  ),
                  child: Text(
                    '1.5+ Years',
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
              spacing: 24 * widget.scale,
              runSpacing: 24 * widget.scale,
              alignment: WrapAlignment.center,
              children: _skillExperiences.map((experience) {
                return _buildExperienceCard(experience);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceCard(SkillExperience experience) {
    return Container(
      width: 300 * widget.scale,
      padding: EdgeInsets.all(24 * widget.scale),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A5F).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20 * widget.scale),
        border: Border.all(color: const Color(0xFF2D4A76), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  experience.skill,
                  style: TextStyle(
                    fontSize: 20 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFCCD6F6),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12 * widget.scale,
                  vertical: 6 * widget.scale,
                ),
                decoration: BoxDecoration(
                  color: _getProficiencyColor(experience.proficiency),
                  borderRadius: BorderRadius.circular(12 * widget.scale),
                ),
                child: Text(
                  experience.proficiency,
                  style: TextStyle(
                    fontSize: 12 * widget.scale,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * widget.scale),
          Row(
            children: [
              _buildExperienceStat('${experience.years}y', 'Experience'),
              SizedBox(width: 20 * widget.scale),
              _buildExperienceStat('${experience.projects}', 'Projects'),
            ],
          ),
          SizedBox(height: 16 * widget.scale),
          LinearProgressIndicator(
            value: experience.years / 2, // Normalize to 0-1 range
            backgroundColor: const Color(0xFF1E3A5F),
            color: _getProficiencyColor(experience.proficiency),
            minHeight: 6 * widget.scale,
            borderRadius: BorderRadius.circular(3 * widget.scale),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18 * widget.scale,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF64FFDA),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13 * widget.scale,
            color: const Color(0xFF8892B0),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressionSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.9 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1800),
      child: Column(
        children: [
          Text(
            'SKILL PROGRESSION',
            style: TextStyle(
              fontSize: 28 * widget.scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 40 * widget.scale),
          Container(
            padding: EdgeInsets.all(40 * widget.scale),
            decoration: BoxDecoration(
              color: const Color(0xFF112240).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(28 * widget.scale),
              border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
            ),
            child: Column(
              children: [
                _buildProgressionTimeline(),
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
                        Icons.trending_up,
                        color: Colors.white,
                        size: 24 * widget.scale,
                      ),
                      SizedBox(width: 12 * widget.scale),
                      Text(
                        'Continuously Learning & Growing',
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
        ],
      ),
    );
  }

  Widget _buildProgressionTimeline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimelineStep(
          'Dart Basics',
          '2022',
          Icons.play_arrow,
          const Color(0xFF00D1FF),
        ),
        SizedBox(width: 40 * widget.scale),
        _buildTimelineStep(
          'Flutter Core',
          '2023',
          Icons.code,
          const Color(0xFF64FFDA),
        ),
        SizedBox(width: 40 * widget.scale),
        _buildTimelineStep(
          'Advanced Patterns',
          '2024',
          Icons.architecture,
          const Color(0xFF7B61FF),
        ),
        SizedBox(width: 40 * widget.scale),
        _buildTimelineStep(
          'Production Apps',
          'Present',
          Icons.rocket_launch,
          const Color(0xFFFFD166),
        ),
      ],
    );
  }

  Widget _buildTimelineStep(
    String title,
    String year,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 80 * widget.scale,
          height: 80 * widget.scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withValues(alpha: 0.7)],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 32 * widget.scale),
        ),
        SizedBox(height: 16 * widget.scale),
        Text(
          title,
          style: TextStyle(
            fontSize: 14 * widget.scale,
            color: const Color(0xFFCCD6F6),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8 * widget.scale),
        Text(
          year,
          style: TextStyle(
            fontSize: 12 * widget.scale,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getProficiencyColor(String proficiency) {
    switch (proficiency.toLowerCase()) {
      case 'expert':
        return const Color(0xFF00D1FF);
      case 'advanced':
        return const Color(0xFF64FFDA);
      case 'intermediate':
        return const Color(0xFF7B61FF);
      default:
        return const Color(0xFFFFD166);
    }
  }

  void _showSkillDetails(BuildContext context, SkillCategory category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.all(40 * widget.scale),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF112240), const Color(0xFF0A192F)],
            ),
            borderRadius: BorderRadius.circular(32 * widget.scale),
            border: Border.all(
              color: category.color.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: category.color.withValues(alpha: 0.2),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(40 * widget.scale),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          category.icon,
                          color: category.color,
                          size: 32 * widget.scale,
                        ),
                        SizedBox(width: 16 * widget.scale),
                        Text(
                          category.title,
                          style: TextStyle(
                            fontSize: 32 * widget.scale,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFCCD6F6),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: const Color(0xFF8892B0),
                        size: 28 * widget.scale,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32 * widget.scale),
                Text(
                  'Skills in this category:',
                  style: TextStyle(
                    fontSize: 24 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: category.color,
                  ),
                ),
                SizedBox(height: 24 * widget.scale),
                ...category.skills.map((skill) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24 * widget.scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              skill.name,
                              style: TextStyle(
                                fontSize: 20 * widget.scale,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFCCD6F6),
                              ),
                            ),
                            Text(
                              '${skill.level}%',
                              style: TextStyle(
                                fontSize: 18 * widget.scale,
                                fontWeight: FontWeight.w600,
                                color: category.color,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8 * widget.scale),
                        Container(
                          height: 8 * widget.scale,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A5F),
                            borderRadius: BorderRadius.circular(
                              4 * widget.scale,
                            ),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: skill.level / 100,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    category.color,
                                    category.color.withValues(alpha: 0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  4 * widget.scale,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8 * widget.scale),
                        Text(
                          skill.description,
                          style: TextStyle(
                            fontSize: 15 * widget.scale,
                            color: const Color(0xFF8892B0),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 40 * widget.scale),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32 * widget.scale,
                      vertical: 16 * widget.scale,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          category.color,
                          category.color.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30 * widget.scale),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.white,
                          size: 20 * widget.scale,
                        ),
                        SizedBox(width: 12 * widget.scale),
                        Text(
                          'View Related Projects',
                          style: TextStyle(
                            fontSize: 18 * widget.scale,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<Skill> skills;

  SkillCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
  });
}

class Skill {
  final String name;
  final int level;
  final String description;

  Skill({required this.name, required this.level, required this.description});
}

class SkillExperience {
  final String skill;
  final double years;
  final int projects;
  final String proficiency;

  SkillExperience({
    required this.skill,
    required this.years,
    required this.projects,
    required this.proficiency,
  });
}
