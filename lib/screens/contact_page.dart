import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final double scale;

  const ContactPage({super.key, required this.scale});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _gradientAnimation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isHoveringEmail = false;
  bool _isHoveringPhone = false;
  bool _isHoveringGitHub = false;
  bool _isHoveringLinkedIn = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: -2, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _gradientAnimation = ColorTween(
      begin: const Color(0xFF00D1FF).withValues(alpha: 0),
      end: const Color(0xFF7B61FF).withValues(alpha: 0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 700), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
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

                    // Main Content - Two Column Layout
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1400 * widget.scale,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column - Contact Info
                          Expanded(flex: 2, child: _buildContactInfoSection()),

                          SizedBox(width: 60 * widget.scale),

                          // Right Column - Contact Form
                          Expanded(flex: 3, child: _buildContactFormSection()),
                        ],
                      ),
                    ),

                    SizedBox(height: 60 * widget.scale),

                    // Social Links & Availability
                    _buildSocialSection(),

                    SizedBox(height: 60 * widget.scale),

                    // Location Map (Optional)
                    _buildLocationSection(),
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
              'GET IN TOUCH',
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
            width: 200 * widget.scale,
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
            'Let\'s build something amazing together',
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

  Widget _buildContactInfoSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.3 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONTACT INFORMATION',
            style: TextStyle(
              fontSize: 28 * widget.scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 32 * widget.scale),

          Container(
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
            child: Column(
              children: [
                // Phone
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringPhone = true),
                  onExit: (_) => setState(() => _isHoveringPhone = false),
                  child: GestureDetector(
                    onTap: () => _launchPhone('+918083217599'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.all(24 * widget.scale),
                      margin: EdgeInsets.only(bottom: 20 * widget.scale),
                      decoration: BoxDecoration(
                        color: _isHoveringPhone
                            ? const Color(0xFF00D1FF).withValues(alpha: 0.1)
                            : const Color(0xFF1E3A5F).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20 * widget.scale),
                        border: Border.all(
                          color: _isHoveringPhone
                              ? const Color(0xFF00D1FF).withValues(alpha: 0.5)
                              : const Color(0xFF2D4A76),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16 * widget.scale),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                              ),
                              borderRadius: BorderRadius.circular(
                                16 * widget.scale,
                              ),
                            ),
                            child: Icon(
                              Icons.phone_iphone,
                              color: Colors.white,
                              size: 24 * widget.scale,
                            ),
                          ),
                          SizedBox(width: 24 * widget.scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone',
                                  style: TextStyle(
                                    fontSize: 14 * widget.scale,
                                    color: const Color(0xFF8892B0),
                                  ),
                                ),
                                SizedBox(height: 4 * widget.scale),
                                Text(
                                  '+91 8083217599',
                                  style: TextStyle(
                                    fontSize: 18 * widget.scale,
                                    color: const Color(0xFFCCD6F6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18 * widget.scale,
                            color: _isHoveringPhone
                                ? const Color(0xFF00D1FF)
                                : const Color(0xFF8892B0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Email
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringEmail = true),
                  onExit: (_) => setState(() => _isHoveringEmail = false),
                  child: GestureDetector(
                    onTap: () => _launchEmail('kundankumarcu@gmail.com'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.all(24 * widget.scale),
                      margin: EdgeInsets.only(bottom: 20 * widget.scale),
                      decoration: BoxDecoration(
                        color: _isHoveringEmail
                            ? const Color(0xFF64FFDA).withValues(alpha: 0.1)
                            : const Color(0xFF1E3A5F).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20 * widget.scale),
                        border: Border.all(
                          color: _isHoveringEmail
                              ? const Color(0xFF64FFDA).withValues(alpha: 0.5)
                              : const Color(0xFF2D4A76),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16 * widget.scale),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF64FFDA), Color(0xFF00D1FF)],
                              ),
                              borderRadius: BorderRadius.circular(
                                16 * widget.scale,
                              ),
                            ),
                            child: Icon(
                              Icons.alternate_email,
                              color: Colors.white,
                              size: 24 * widget.scale,
                            ),
                          ),
                          SizedBox(width: 24 * widget.scale),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 14 * widget.scale,
                                    color: const Color(0xFF8892B0),
                                  ),
                                ),
                                SizedBox(height: 4 * widget.scale),
                                Text(
                                  'kundankumarcu@gmail.com',
                                  style: TextStyle(
                                    fontSize: 18 * widget.scale,
                                    color: const Color(0xFFCCD6F6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18 * widget.scale,
                            color: _isHoveringEmail
                                ? const Color(0xFF64FFDA)
                                : const Color(0xFF8892B0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Availability
                Container(
                  padding: EdgeInsets.all(24 * widget.scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A5F).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20 * widget.scale),
                    border: Border.all(
                      color: const Color(0xFF7B61FF).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16 * widget.scale),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7B61FF), Color(0xFF00D1FF)],
                          ),
                          borderRadius: BorderRadius.circular(
                            16 * widget.scale,
                          ),
                        ),
                        child: Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 24 * widget.scale,
                        ),
                      ),
                      SizedBox(width: 24 * widget.scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Response Time',
                              style: TextStyle(
                                fontSize: 14 * widget.scale,
                                color: const Color(0xFF8892B0),
                              ),
                            ),
                            SizedBox(height: 4 * widget.scale),
                            Text(
                              'Within 24 hours',
                              style: TextStyle(
                                fontSize: 18 * widget.scale,
                                color: const Color(0xFFCCD6F6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * widget.scale,
                          vertical: 8 * widget.scale,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B61FF).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                            20 * widget.scale,
                          ),
                          border: Border.all(
                            color: const Color(
                              0xFF7B61FF,
                            ).withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Available',
                          style: TextStyle(
                            fontSize: 14 * widget.scale,
                            color: const Color(0xFF7B61FF),
                            fontWeight: FontWeight.w600,
                          ),
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

  Widget _buildContactFormSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.5 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEND A MESSAGE',
            style: TextStyle(
              fontSize: 28 * widget.scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 32 * widget.scale),

          Container(
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
                color: const Color(0xFF64FFDA).withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                // Name & Email Row
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _nameController,
                        label: 'Your Name',
                        icon: Icons.person_outline,
                        hint: 'Enter your full name',
                      ),
                    ),
                    SizedBox(width: 24 * widget.scale),
                    Expanded(
                      child: _buildTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24 * widget.scale),

                // Subject
                _buildTextField(
                  controller: _subjectController,
                  label: 'Subject',
                  icon: Icons.subject,
                  hint: 'What is this regarding?',
                ),
                SizedBox(height: 24 * widget.scale),

                // Message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Message',
                      style: TextStyle(
                        fontSize: 14 * widget.scale,
                        color: const Color(0xFF8892B0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8 * widget.scale),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A5F).withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16 * widget.scale),
                        border: Border.all(
                          color: const Color(0xFF2D4A76),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _messageController,
                        maxLines: 6,
                        style: TextStyle(
                          fontSize: 16 * widget.scale,
                          color: const Color(0xFFCCD6F6),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Tell me about your project or inquiry...',
                          hintStyle: TextStyle(
                            color: const Color(
                              0xFF8892B0,
                            ).withValues(alpha: 0.7),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20 * widget.scale),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40 * widget.scale),

                // Submit Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _submitForm,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32 * widget.scale,
                        vertical: 20 * widget.scale,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00D1FF), Color(0xFF7B61FF)],
                        ),
                        borderRadius: BorderRadius.circular(30 * widget.scale),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF00D1FF,
                            ).withValues(alpha: 0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 24 * widget.scale,
                          ),
                          SizedBox(width: 16 * widget.scale),
                          Text(
                            'Send Message',
                            style: TextStyle(
                              fontSize: 20 * widget.scale,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24 * widget.scale),

                Text(
                  'I\'ll get back to you as soon as possible!',
                  style: TextStyle(
                    fontSize: 14 * widget.scale,
                    color: const Color(0xFF8892B0),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14 * widget.scale,
            color: const Color(0xFF8892B0),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8 * widget.scale),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A5F).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16 * widget.scale),
            border: Border.all(color: const Color(0xFF2D4A76), width: 1),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20 * widget.scale),
                child: Icon(
                  icon,
                  color: const Color(0xFF64FFDA),
                  size: 20 * widget.scale,
                ),
              ),
              SizedBox(width: 12 * widget.scale),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontSize: 16 * widget.scale,
                    color: const Color(0xFFCCD6F6),
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: const Color(0xFF8892B0).withValues(alpha: 0.7),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18 * widget.scale,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.7 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1600),
      child: Column(
        children: [
          Text(
            'CONNECT WITH ME',
            style: TextStyle(
              fontSize: 28 * widget.scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 32 * widget.scale),

          Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // GitHub
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringGitHub = true),
                  onExit: (_) => setState(() => _isHoveringGitHub = false),
                  child: GestureDetector(
                    onTap: () => _launchURL('https://github.com/DevZkund'),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 120 * widget.scale,
                          height: 120 * widget.scale,
                          decoration: BoxDecoration(
                            gradient: _isHoveringGitHub
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF333333),
                                      Color(0xFF24292e),
                                    ],
                                  )
                                : null,
                            color: _isHoveringGitHub
                                ? null
                                : const Color(
                                    0xFF1E3A5F,
                                  ).withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isHoveringGitHub
                                  ? const Color(0xFF64FFDA)
                                  : const Color(0xFF2D4A76),
                              width: 2,
                            ),
                            boxShadow: _isHoveringGitHub
                                ? [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF64FFDA,
                                      ).withValues(alpha: 0.4),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            Icons.code,
                            color: _isHoveringGitHub
                                ? const Color(0xFF64FFDA)
                                : const Color(0xFFCCD6F6),
                            size: 48 * widget.scale,
                          ),
                        ),
                        SizedBox(height: 16 * widget.scale),
                        Text(
                          'GitHub',
                          style: TextStyle(
                            fontSize: 18 * widget.scale,
                            color: const Color(0xFFCCD6F6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4 * widget.scale),
                        Text(
                          'github.com/DevZkund',
                          style: TextStyle(
                            fontSize: 14 * widget.scale,
                            color: const Color(0xFF8892B0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // LinkedIn
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringLinkedIn = true),
                  onExit: (_) => setState(() => _isHoveringLinkedIn = false),
                  child: GestureDetector(
                    onTap: () => _launchURL('https://linkedin.com/in/devzkund'),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 120 * widget.scale,
                          height: 120 * widget.scale,
                          decoration: BoxDecoration(
                            gradient: _isHoveringLinkedIn
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF0077B5),
                                      Color(0xFF00A0DC),
                                    ],
                                  )
                                : null,
                            color: _isHoveringLinkedIn
                                ? null
                                : const Color(
                                    0xFF1E3A5F,
                                  ).withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isHoveringLinkedIn
                                  ? const Color(0xFF00D1FF)
                                  : const Color(0xFF2D4A76),
                              width: 2,
                            ),
                            boxShadow: _isHoveringLinkedIn
                                ? [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF00D1FF,
                                      ).withValues(alpha: 0.4),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            Icons.linked_camera,
                            color: _isHoveringLinkedIn
                                ? Colors.white
                                : const Color(0xFFCCD6F6),
                            size: 48 * widget.scale,
                          ),
                        ),
                        SizedBox(height: 16 * widget.scale),
                        Text(
                          'LinkedIn',
                          style: TextStyle(
                            fontSize: 18 * widget.scale,
                            color: const Color(0xFFCCD6F6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4 * widget.scale),
                        Text(
                          'linkedin.com/in/devzkund',
                          style: TextStyle(
                            fontSize: 14 * widget.scale,
                            color: const Color(0xFF8892B0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection() {
    return AnimatedOpacity(
      opacity: _controller.value > 0.9 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1800),
      child: Column(
        children: [
          Text(
            'LOCATION',
            style: TextStyle(
              fontSize: 28 * widget.scale,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCCD6F6),
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 32 * widget.scale),

          Container(
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
                color: const Color(0xFF64FFDA).withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                // Location Icon
                Container(
                  width: 100 * widget.scale,
                  height: 100 * widget.scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D1FF).withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 48 * widget.scale,
                  ),
                ),
                SizedBox(height: 32 * widget.scale),
                Text(
                  'Based in Mohali, Punjab, India',
                  style: TextStyle(
                    fontSize: 24 * widget.scale,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFCCD6F6),
                  ),
                ),
                SizedBox(height: 16 * widget.scale),
                Text(
                  'Available for remote work & freelance projects worldwide',
                  style: TextStyle(
                    fontSize: 18 * widget.scale,
                    color: const Color(0xFF8892B0),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32 * widget.scale),
                Container(
                  width: double.infinity,
                  height: 200 * widget.scale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20 * widget.scale),
                    color: const Color(0xFF1E3A5F),
                    border: Border.all(
                      color: const Color(0xFF2D4A76),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          color: const Color(0xFF64FFDA),
                          size: 48 * widget.scale,
                        ),
                        SizedBox(height: 16 * widget.scale),
                        Text(
                          'Interactive Map',
                          style: TextStyle(
                            fontSize: 18 * widget.scale,
                            color: const Color(0xFFCCD6F6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8 * widget.scale),
                        Text(
                          'Click to view location on map',
                          style: TextStyle(
                            fontSize: 14 * widget.scale,
                            color: const Color(0xFF8892B0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32 * widget.scale),
                Text(
                  '🌎 Open to relocation opportunities',
                  style: TextStyle(
                    fontSize: 16 * widget.scale,
                    color: const Color(0xFF64FFDA),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    // Handle form submission
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      _showSnackBar('Please fill all required fields');
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showSnackBar('Please enter a valid email address');
      return;
    }

    // Show success message
    _showSuccessDialog(name);

    // Clear form
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF476F),
      ),
    );
  }

  void _showSuccessDialog(String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF112240),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24 * widget.scale),
            side: const BorderSide(color: Color(0xFF64FFDA), width: 2),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: const Color(0xFF64FFDA),
                size: 32 * widget.scale,
              ),
              SizedBox(width: 16 * widget.scale),
              Text(
                'Message Sent!',
                style: TextStyle(
                  fontSize: 24 * widget.scale,
                  color: const Color(0xFFCCD6F6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Text(
            'Thanks $name! Your message has been sent successfully. I\'ll get back to you within 24 hours.',
            style: TextStyle(
              fontSize: 16 * widget.scale,
              color: const Color(0xFF8892B0),
              height: 1.6,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 16 * widget.scale,
                  color: const Color(0xFF64FFDA),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _launchPhone(String phone) {
    // Implementation for launching phone dialer
    print('Launch phone: $phone');
  }

  void _launchEmail(String email) {
    // Implementation for launching email client
    print('Launch email: $email');
  }

  void _launchURL(String url) {
    // Implementation for launching URL
    print('Launch URL: $url');
  }
}
