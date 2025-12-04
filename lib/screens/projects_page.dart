import 'package:flutter/material.dart';

class ProjectsPage extends StatefulWidget {
  final double scale;

  const ProjectsPage({super.key, required this.scale});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _gradientAnimation;
  int _selectedCategory = 0;
  final List<String> _categories = [
    'All',
    'Professional',
    'Freelance',
    'Personal',
  ];

  final List<Project> _projects = [
    Project(
      title: 'Tax HelpDesk',
      category: 'Professional',
      description:
          'A complete online tax filing and document management application built to simplify tax workflows. I developed core modules improving app performance, UI consistency, and stability across the entire system. Integrated REST APIs for tax filing processes, document uploads, and verification pipelines. Implemented secure authentication, push notifications, and real-time status tracking to ensure users stay updated throughout their filing cycle.',
      technologies: [
        'Flutter',
        'REST API',
        'Authentication',
        'Push Notifications',
        'GetX / BLoC',
      ],
      features: [
        'Document upload & verification',
        'Tax filing workflows',
        'Real-time status tracking',
        'Secure authentication system',
      ],
      role: 'Flutter Developer',
      period: '2024',
    ),

    Project(
      title: 'Isomeds',
      category: 'Professional',
      description:
          'A full-featured e-commerce medicine delivery application supporting prescription uploads, secure payments, and order tracking. I built major modules including product browsing, cart handling, checkout, and prescription management. Developed a smooth and responsive UI using GetX state management and handled performance optimizations to reduce lag and loading times across devices.',
      technologies: ['Flutter', 'GetX', 'Payment Gateway', 'Firebase'],
      features: [
        'Medicine ordering system',
        'Cart management',
        'Prescription upload',
        'Secure payments',
        'Order tracking & notifications',
      ],
      role: 'Flutter Developer',
      period: '2024',
    ),

    Project(
      title: 'Kaam Dhanda',
      category: 'Professional',
      description:
          'A B2B and job portal platform designed to connect job seekers with employers. I built modules allowing users to create professional resumes, browse localized job listings, and apply directly within the app. On the employer side, implemented features such as job posting, candidate shortlisting, and application tracking. Integrated real-time listings, category-based filtering, and clean UI components for a fast and intuitive experience.',
      technologies: ['Flutter', 'BLoC', 'GetX', 'Real-time', 'User Profiles'],
      features: [
        'Professional resume builder',
        'Job posting & applications',
        'Candidate shortlisting',
        'Real-time job listings',
      ],
      role: 'Flutter Developer',
      period: '2024',
    ),

    Project(
      title: 'FMS (Factory Management System)',
      category: 'Professional',
      description:
          'A comprehensive factory workflow and operations management system currently under development. Built using Flutter, shadcn/ui design components, and BLoC (Cubit) architecture. I am responsible for modules handling production tracking, order flow, machine status monitoring, and employee task management. Focused on creating scalable components and real-time updates to support factory-level operations efficiently.',
      technologies: ['Flutter', 'shadcn/ui', 'BLoC (Cubit)', 'Real-time'],
      features: [
        'Production tracking',
        'Order management',
        'Machine status monitoring',
        'Employee task workflows',
      ],
      role: 'Flutter Developer',
      period: 'Current',
    ),

    Project(
      title: 'School Management System',
      category: 'Professional',
      description:
          'A complete school administration application designed for managing students, teachers, and academic workflows. Built modules for attendance tracking, leave management, teacher–student chat, anecdotal notes, and academic record handling. Integrated Firebase for real-time updates and efficient data syncing across user roles.',
      technologies: ['Flutter', 'Firebase', 'Real-time Chat'],
      features: [
        'Student attendance tracking',
        'Leave management system',
        'Teacher–student chat',
        'Anecdotal notes & academic records',
      ],
      role: 'Flutter Developer',
      period: '2024',
    ),

    Project(
      title: 'Video Player App',
      category: 'Freelance',
      description:
          'A modern video player application supporting both online streaming and offline local playback. Built smooth gesture-based controls, implemented GetX for reactive UI updates, and optimized buffering to ensure seamless playback on both phones and tablets. Focused on reducing lag and improving the overall user experience in real-time.',
      technologies: ['Flutter', 'GetX', 'Video Streaming'],
      features: [
        'Online streaming support',
        'Local video playback',
        'Smooth video controls',
        'Reactive UI updates',
      ],
      role: 'Freelance Developer',
      period: '2023',
    ),

    Project(
      title: 'Firebase Chat App',
      category: 'Personal',
      description:
          'A full real-time chat application built using Firebase Authentication, Firestore database, and Cloud Messaging. Implemented one-on-one and group chat, instant messaging, image sharing, emoji reactions, offline persistence, and notification handling. Designed with a clean real-time architecture to ensure reliability even with low network connectivity.',
      technologies: ['Flutter', 'Firebase', 'Firestore', 'Cloud Messaging'],
      features: [
        'One-on-one & group chat',
        'Image & emoji sharing',
        'Offline persistence',
        'Push notifications',
      ],
      role: 'Full Stack Developer',
      period: '2023',
    ),

    Project(
      title: 'Quiz App',
      category: 'Personal',
      description:
          'An interactive quiz application designed with dynamic question generation, real-time scoring, timers, and local storage for saving user progress and high scores. Created with responsive UI layouts following Material Design principles to support multiple screen sizes. Built as a personal project to strengthen UI/UX consistency and state handling.',
      technologies: ['Flutter', 'Local Storage', 'Timer'],
      features: [
        'Dynamic question system',
        'Real-time scoring',
        'Timer-based questions',
        'Progress tracking',
      ],
      role: 'Solo Developer',
      period: '2023',
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

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: const Color(0xFF00D1FF).withValues(alpha: 0),
      end: const Color(0xFF00D1FF).withValues(alpha: 0.1),
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

  List<Project> get _filteredProjects {
    if (_selectedCategory == 0) return _projects;
    return _projects
        .where((project) => project.category == _categories[_selectedCategory])
        .toList();
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
            child: Transform.scale(
              scale: _scaleAnimation.value,
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

                    SizedBox(height: 40 * widget.scale),

                    // Category Filters
                    _buildCategoryFilters(),

                    SizedBox(height: 40 * widget.scale),

                    // Projects Grid
                    _buildProjectsGrid(),

                    SizedBox(height: 60 * widget.scale),

                    // Stats Section
                    _buildStatsSection(),
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
      duration: const Duration(milliseconds: 900),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
            ).createShader(bounds),
            child: Text(
              'PROJECT PORTFOLIO',
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
            width: 300 * widget.scale,
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
            '${_projects.length} Projects • 1.5+ Years of Development',
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

  Widget _buildCategoryFilters() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.3 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: Container(
        padding: EdgeInsets.all(20 * widget.scale),
        decoration: BoxDecoration(
          color: const Color(0xFF112240).withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20 * widget.scale),
          border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
        ),
        child: Wrap(
          spacing: 16 * widget.scale,
          runSpacing: 12 * widget.scale,
          alignment: WrapAlignment.center,
          children: List.generate(_categories.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                  horizontal: 24 * widget.scale,
                  vertical: 14 * widget.scale,
                ),
                decoration: BoxDecoration(
                  gradient: _selectedCategory == index
                      ? const LinearGradient(
                          colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                        )
                      : null,
                  color: _selectedCategory == index
                      ? null
                      : const Color(0xFF1E3A5F).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(30 * widget.scale),
                  border: Border.all(
                    color: _selectedCategory == index
                        ? Colors.transparent
                        : const Color(0xFF2D4A76),
                    width: 1,
                  ),
                  boxShadow: _selectedCategory == index
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF00D1FF,
                            ).withValues(alpha: 0.4),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    fontSize: 16 * widget.scale,
                    color: _selectedCategory == index
                        ? Colors.white
                        : const Color(0xFFCCD6F6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.4 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1100),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1,
          crossAxisSpacing: 32 * widget.scale,
          mainAxisSpacing: 32 * widget.scale,
          childAspectRatio: 1.4,
        ),
        itemCount: _filteredProjects.length,
        itemBuilder: (context, index) {
          return _buildProjectCard(_filteredProjects[index], index);
        },
      ),
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _showProjectDetails(context, project);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF112240).withValues(alpha: 0.9),
                _gradientAnimation.value!,
              ],
            ),
            borderRadius: BorderRadius.circular(24 * widget.scale),
            border: Border.all(color: const Color(0xFF1E3A5F), width: 1),
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
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * widget.scale,
                    vertical: 8 * widget.scale,
                  ),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(project.category),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24 * widget.scale),
                      bottomLeft: Radius.circular(12 * widget.scale),
                    ),
                  ),
                  child: Text(
                    project.category,
                    style: TextStyle(
                      fontSize: 12 * widget.scale,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32 * widget.scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            project.title,
                            style: TextStyle(
                              fontSize: 24 * widget.scale,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFCCD6F6),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12 * widget.scale,
                            vertical: 6 * widget.scale,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A5F),
                            borderRadius: BorderRadius.circular(
                              12 * widget.scale,
                            ),
                          ),
                          child: Text(
                            project.period,
                            style: TextStyle(
                              fontSize: 12 * widget.scale,
                              color: const Color(0xFF64FFDA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * widget.scale),
                    Text(
                      project.description,
                      style: TextStyle(
                        fontSize: 14 * widget.scale,
                        color: const Color(0xFF8892B0),
                        height: 1.6,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 20 * widget.scale),
                    Text(
                      'Role: ${project.role}',
                      style: TextStyle(
                        fontSize: 13 * widget.scale,
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16 * widget.scale),
                    Wrap(
                      spacing: 8 * widget.scale,
                      runSpacing: 8 * widget.scale,
                      children: project.technologies.take(3).map((tech) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10 * widget.scale,
                            vertical: 6 * widget.scale,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF1E3A5F,
                            ).withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(
                              8 * widget.scale,
                            ),
                            border: Border.all(
                              color: const Color(0xFF2D4A76),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tech,
                            style: TextStyle(
                              fontSize: 11 * widget.scale,
                              color: const Color(0xFF8892B0),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 14 * widget.scale,
                            color: const Color(0xFF00D1FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8 * widget.scale),
                        Icon(
                          Icons.arrow_forward,
                          size: 16 * widget.scale,
                          color: const Color(0xFF00D1FF),
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

  Widget _buildStatsSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.8 ? 1.0 : 0.0,
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
            color: const Color(0xFF00D1FF).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF64FFDA), Color(0xFF00D1FF)],
              ).createShader(bounds),
              child: Text(
                'PROJECT STATISTICS',
                style: TextStyle(
                  fontSize: 32 * widget.scale,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: const Color(0xFF64FFDA),
                ),
              ),
            ),
            SizedBox(height: 40 * widget.scale),
            Wrap(
              spacing: 40 * widget.scale,
              runSpacing: 40 * widget.scale,
              alignment: WrapAlignment.center,
              children: [
                _buildStatItem('8', 'Total Projects'),
                _buildStatItem('5', 'Professional Projects'),
                _buildStatItem('1', 'Freelance Projects'),
                _buildStatItem('2', 'Personal Projects'),
                _buildStatItem('98%', 'Client Satisfaction'),
                _buildStatItem('1.5+', 'Years Experience'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 42 * widget.scale,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF64FFDA),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8 * widget.scale),
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Professional':
        return const Color(0xFF00D1FF);
      case 'Freelance':
        return const Color(0xFF7B61FF);
      case 'Personal':
        return const Color(0xFF64FFDA);
      default:
        return const Color(0xFF00D1FF);
    }
  }

  void _showProjectDetails(BuildContext context, Project project) {
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
              color: const Color(0xFF00D1FF).withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
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
                    Expanded(
                      child: Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 32 * widget.scale,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFCCD6F6),
                        ),
                      ),
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
                SizedBox(height: 16 * widget.scale),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16 * widget.scale,
                        vertical: 8 * widget.scale,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(project.category),
                        borderRadius: BorderRadius.circular(20 * widget.scale),
                      ),
                      child: Text(
                        project.category,
                        style: TextStyle(
                          fontSize: 14 * widget.scale,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 16 * widget.scale),
                    Text(
                      'Period: ${project.period}',
                      style: TextStyle(
                        fontSize: 16 * widget.scale,
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 16 * widget.scale),
                    Text(
                      'Role: ${project.role}',
                      style: TextStyle(
                        fontSize: 16 * widget.scale,
                        color: const Color(0xFF8892B0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32 * widget.scale),
                Text(
                  project.description,
                  style: TextStyle(
                    fontSize: 18 * widget.scale,
                    color: const Color(0xFFCCD6F6),
                    height: 1.7,
                  ),
                ),
                SizedBox(height: 32 * widget.scale),
                Text(
                  'Key Features:',
                  style: TextStyle(
                    fontSize: 24 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64FFDA),
                  ),
                ),
                SizedBox(height: 16 * widget.scale),
                Wrap(
                  spacing: 16 * widget.scale,
                  runSpacing: 12 * widget.scale,
                  children: project.features.map((feature) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20 * widget.scale,
                        vertical: 12 * widget.scale,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A5F).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12 * widget.scale),
                        border: Border.all(
                          color: const Color(0xFF2D4A76),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFF64FFDA),
                            size: 16 * widget.scale,
                          ),
                          SizedBox(width: 8 * widget.scale),
                          Text(
                            feature,
                            style: TextStyle(
                              fontSize: 14 * widget.scale,
                              color: const Color(0xFFCCD6F6),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 32 * widget.scale),
                Text(
                  'Technologies Used:',
                  style: TextStyle(
                    fontSize: 24 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64FFDA),
                  ),
                ),
                SizedBox(height: 16 * widget.scale),
                Wrap(
                  spacing: 12 * widget.scale,
                  runSpacing: 12 * widget.scale,
                  children: project.technologies.map((tech) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20 * widget.scale,
                        vertical: 10 * widget.scale,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(191, 0, 208, 255),
                            Color.fromARGB(182, 100, 255, 219),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20 * widget.scale),
                      ),
                      child: Text(
                        tech,
                        style: TextStyle(
                          fontSize: 14 * widget.scale,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20 * widget.scale),
                // Center(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 32 * widget.scale,
                //       vertical: 16 * widget.scale,
                //     ),
                //     decoration: BoxDecoration(
                //       gradient: const LinearGradient(
                //         colors: [Color(0xFF00D1FF), Color(0xFF7B61FF)],
                //       ),
                //       borderRadius: BorderRadius.circular(30 * widget.scale),
                //     ),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Icon(
                //           Icons.code,
                //           color: Colors.white,
                //           size: 20 * widget.scale,
                //         ),
                //         SizedBox(width: 12 * widget.scale),
                //         Text(
                //           'View Source Code',
                //           style: TextStyle(
                //             fontSize: 18 * widget.scale,
                //             color: Colors.white,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Project {
  final String title;
  final String category;
  final String description;
  final List<String> technologies;
  final List<String> features;
  final String role;
  final String period;

  Project({
    required this.title,
    required this.category,
    required this.description,
    required this.technologies,
    required this.features,
    required this.role,
    required this.period,
  });
}
