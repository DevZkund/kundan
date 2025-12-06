import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late Animation<Offset> _slideAnimation;

  bool _isHoveringEmail = false;
  bool _isHoveringPhone = false;
  bool _isHoveringGitHub = false;
  bool _isHoveringLinkedIn = false;

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
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 30), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
        );

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
              ? widget.scale * 0.8
              : widget.scale;

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: (isSmallScreen ? 16 : 32) * widget.scale,
                      vertical: 40 * widget.scale,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header Section
                        _buildHeaderSection(responsiveScale),
                        SizedBox(height: 60 * widget.scale),

                        // Main Content
                        SlideTransition(
                          position: _slideAnimation,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 1200 * widget.scale,
                            ),
                            child: Column(
                              children: [
                                // Contact Cards Grid
                                _buildContactCardsGrid(responsiveScale),
                                SizedBox(height: 60 * widget.scale),

                                // Social Media Section
                                _buildSocialMediaSection(
                                  responsiveScale,
                                  isSmallScreen,
                                ),
                                SizedBox(height: 60 * widget.scale),

                                // Location & Availability
                                _buildLocationSection(
                                  responsiveScale,
                                  isSmallScreen,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: 42 * scale, // Reduced base size
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              height: 1.2,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20 * widget.scale),
        Container(
          width: 80 * widget.scale,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00D1FF), Color(0xFF64FFDA)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: 24 * widget.scale),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * widget.scale),
          child: Text(
            'Feel free to reach out if you\'re looking for a developer, have a question, or just want to connect.',
            style: TextStyle(
              fontSize: 16 * scale,
              color: const Color(0xFF8892B0),
              fontWeight: FontWeight.w300,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCardsGrid(double scale) {
    return Column(
      children: [
        Text(
          'CONTACT INFORMATION',
          style: TextStyle(
            fontSize: 12 * scale,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64FFDA),
            letterSpacing: 3,
          ),
        ),
        SizedBox(height: 32 * widget.scale),
        Wrap(
          spacing: 20 * widget.scale,
          runSpacing: 20 * widget.scale,
          alignment: WrapAlignment.center,
          children: [
            _buildContactCard(
              scale: scale,
              icon: Icons.phone_iphone_rounded,
              title: 'Phone',
              subtitle: '+91 8083217599',
              actionText: 'Tap to Call',
              gradient: const [Color(0xFF00D1FF), Color(0xFF0077FF)],
              onTap: () => _launchPhone('+918083217599'),
              isHovering: _isHoveringPhone,
              onHover: (value) => setState(() => _isHoveringPhone = value),
            ),
            _buildContactCard(
              scale: scale,
              icon: Icons.email_rounded,
              title: 'Email',
              subtitle: 'kundankumarcu@gmail.com',
              actionText: 'Send Email',
              gradient: const [Color(0xFF64FFDA), Color(0xFF00B894)],
              onTap: () => _launchEmail('kundankumarcu@gmail.com'),
              isHovering: _isHoveringEmail,
              onHover: (value) => setState(() => _isHoveringEmail = value),
            ),
            _buildContactCard(
              scale: scale,
              icon: Icons.access_time_rounded,
              title: 'Response Time',
              subtitle: 'Within 24 hours',
              actionText: 'Currently Available',
              gradient: const [Color(0xFF7B61FF), Color(0xFF9D4EDD)],
              onTap: () {},
              isHovering: false,
              onHover: (_) {},
              showStatus: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required double scale,
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
    required List<Color> gradient,
    required VoidCallback onTap,
    required bool isHovering,
    required Function(bool) onHover,
    bool showStatus = false,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 280 * scale, // Slightly smaller card base
          height: 280 * scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24 * widget.scale),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isHovering
                  ? gradient
                  : [const Color(0xFF112240), const Color(0xFF1E3A5F)],
            ),
            boxShadow: [
              BoxShadow(
                color: isHovering
                    ? gradient[0].withValues(alpha: 0.3)
                    : const Color(0xFF000000).withValues(alpha: 0.2),
                blurRadius: 30,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: isHovering
                  ? gradient[0].withValues(alpha: 0.5)
                  : const Color(0xFF2D4A76),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24 * scale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28 * scale),
                ),
                SizedBox(height: 20 * scale),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13 * scale,
                    color: const Color(0xFF8892B0),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16 * scale,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20 * scale),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14 * scale,
                    vertical: 8 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: isHovering
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16 * scale),
                    border: Border.all(
                      color: isHovering
                          ? Colors.white.withValues(alpha: 0.3)
                          : const Color(0xFF8892B0).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        actionText,
                        style: TextStyle(
                          fontSize: 11 * scale,
                          color: isHovering
                              ? Colors.white
                              : const Color(0xFF8892B0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isHovering) ...[
                        SizedBox(width: 8 * scale),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 12 * scale,
                          color: Colors.white,
                        ),
                      ],
                    ],
                  ),
                ),
                if (showStatus) ...[
                  SizedBox(height: 14 * scale),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10 * scale,
                      vertical: 4 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF64FFDA).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10 * scale),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: TextStyle(
                        fontSize: 9 * scale,
                        color: const Color(0xFF64FFDA),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection(double scale, bool isSmallScreen) {
    return Column(
      children: [
        Text(
          'SOCIAL CONNECTIONS',
          style: TextStyle(
            fontSize: 12 * scale,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64FFDA),
            letterSpacing: 3,
          ),
        ),
        SizedBox(height: 32 * widget.scale),
        Container(
          padding: EdgeInsets.all(
            isSmallScreen ? 20 * widget.scale : 40 * widget.scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32 * widget.scale),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF112240).withValues(alpha: 0.8),
                const Color(0xFF1E3A5F).withValues(alpha: 0.4),
              ],
            ),
            border: Border.all(color: const Color(0xFF2D4A76), width: 1),
          ),
          child: Column(
            children: [
              // Use Wrap or Column for social buttons based on space
              Wrap(
                spacing: 20 * scale,
                runSpacing: 20 * scale,
                alignment: WrapAlignment.center,
                children: [
                  _buildSocialButton(
                    scale: scale,
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    username: '@DevZkund',
                    url: 'https://github.com/DevZkund',
                    gradient: const [Color(0xFF333333), Color(0xFF24292e)],
                    isHovering: _isHoveringGitHub,
                    onHover: (value) =>
                        setState(() => _isHoveringGitHub = value),
                  ),
                  // Removed SizedBox and used Wrap spacing instead
                  _buildSocialButton(
                    scale: scale,
                    icon: Icons.linked_camera_rounded,
                    label: 'LinkedIn',
                    username: '@devzkund',
                    url: 'https://linkedin.com/in/devzkund',
                    gradient: const [Color(0xFF0077B5), Color(0xFF00A0DC)],
                    isHovering: _isHoveringLinkedIn,
                    onHover: (value) =>
                        setState(() => _isHoveringLinkedIn = value),
                  ),
                ],
              ),
              SizedBox(height: 40 * widget.scale),
              Text(
                'Let\'s connect and collaborate',
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: const Color(0xFF8892B0),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required double scale,
    required IconData icon,
    required String label,
    required String username,
    required String url,
    required List<Color> gradient,
    required bool isHovering,
    required Function(bool) onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () => _launchURL(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 180 * scale,
          padding: EdgeInsets.all(20 * scale),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20 * widget.scale),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isHovering
                  ? gradient
                  : [const Color(0xFF1E3A5F), const Color(0xFF112240)],
            ),
            boxShadow: isHovering
                ? [
                    BoxShadow(
                      color: gradient[0].withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
            border: Border.all(
              color: isHovering
                  ? Colors.white.withValues(alpha: 0.3)
                  : const Color(0xFF2D4A76),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 50 * scale,
                height: 50 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 24 * scale),
              ),
              SizedBox(height: 16 * scale),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16 * scale,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                username,
                style: TextStyle(
                  fontSize: 12 * scale,
                  color: const Color(0xFF8892B0),
                ),
              ),
              SizedBox(height: 16 * scale),
              AnimatedOpacity(
                opacity: isHovering ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12 * scale,
                    vertical: 6 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Visit Profile',
                        style: TextStyle(
                          fontSize: 10 * scale,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      Icon(
                        Icons.arrow_outward_rounded,
                        size: 10 * scale,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection(double scale, bool isSmallScreen) {
    return Column(
      children: [
        Text(
          'LOCATION & AVAILABILITY',
          style: TextStyle(
            fontSize: 12 * scale,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64FFDA),
            letterSpacing: 3,
          ),
        ),
        SizedBox(height: 32 * widget.scale),
        Container(
          padding: EdgeInsets.all(
            isSmallScreen ? 20 * widget.scale : 40 * widget.scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32 * widget.scale),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF1E3A5F), const Color(0xFF112240)],
            ),
            border: Border.all(
              color: const Color(0xFF00D1FF).withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              // Responsive Row/Column for location icon + text
              isSmallScreen
                  ? Column(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: const Color(0xFF64FFDA),
                          size: 24 * scale,
                        ),
                        SizedBox(height: 8 * scale),
                        Text(
                          'Mohali, Punjab, India',
                          style: TextStyle(
                            fontSize: 20 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: const Color(0xFF64FFDA),
                          size: 24 * scale,
                        ),
                        SizedBox(width: 12 * widget.scale),
                        Text(
                          'Mohali, Punjab, India',
                          style: TextStyle(
                            fontSize: 24 * scale,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

              SizedBox(height: 24 * widget.scale),
              Text(
                '📍 Open to remote opportunities worldwide',
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: const Color(0xFF8892B0),
                ),
              ),
              SizedBox(height: 32 * widget.scale),
              Wrap(
                spacing: 12 * widget.scale,
                runSpacing: 12 * widget.scale,
                alignment: WrapAlignment.center,
                children: [
                  _buildTag(scale, 'Remote Work', const Color(0xFF00D1FF)),
                  _buildTag(scale, 'Full-time', const Color(0xFF64FFDA)),
                  _buildTag(scale, 'Freelance', const Color(0xFF7B61FF)),
                  _buildTag(scale, 'Contract', const Color(0xFFFF6B6B)),
                  _buildTag(scale, 'Relocation', const Color(0xFFFFD166)),
                ],
              ),
              SizedBox(height: 40 * widget.scale),
              Container(
                padding: EdgeInsets.all(24 * widget.scale),
                decoration: BoxDecoration(
                  color: const Color(0xFF112240),
                  borderRadius: BorderRadius.circular(20 * widget.scale),
                  border: Border.all(color: const Color(0xFF2D4A76), width: 1),
                ),
                child: isSmallScreen
                    ? Column(children: _buildTimezoneChildren(scale))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildTimezoneChildren(scale),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTimezoneChildren(double scale) {
    return [
      Icon(
        Icons.access_time_rounded,
        color: const Color(0xFF64FFDA),
        size: 18 * scale,
      ),
      SizedBox(width: 12 * widget.scale),
      Text(
        'Time Zone: IST (UTC+5:30)',
        style: TextStyle(
          fontSize: 14 * scale,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        width: 24 * widget.scale,
        height: 12 * widget.scale,
      ), // Flexible spacer
      Container(
        width: 6,
        height: 6,
        decoration: const BoxDecoration(
          color: Color(0xFF64FFDA),
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 12 * widget.scale),
      Text(
        'Available Now',
        style: TextStyle(
          fontSize: 14 * scale,
          color: const Color(0xFF64FFDA),
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
  }

  Widget _buildTag(double scale, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 8 * scale,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20 * widget.scale),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8 * widget.scale),
          Text(
            text,
            style: TextStyle(
              fontSize: 12 * scale,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
