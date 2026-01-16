import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:portfolio/screens/resume_screen.dart';

class LandingPage extends StatefulWidget {
  final double scale;

  const LandingPage({super.key, required this.scale});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late ScrollController _scrollController;
  final GlobalKey _projectsKey = GlobalKey();

  // Typing animation text
  final List<String> _typingTexts = [
    'Flutter Developer',
    'Cross-Platform Expert',
    'Mobile App Developer',
    'Full-Stack Enthusiast',
  ];
  int _typingIndex = 0;
  String _displayText = '';
  bool _isDeleting = false;
  Timer? _typingTimer;
  bool _isFrozen = false;
  bool _showHint = true;

  // Constants for maintainability
  static const _primaryColor = Color(0xFF0F1B2D); // Deep Navy
  static const _secondaryColor = Color(0xFF1A2B44); // Medium Navy
  static const _accentColor = Color(0xFF00C2FF); // Bright Cyan
  static const _lightAccent = Color(0xFF5AEDDA); // Teal
  static const _purpleAccent = Color(0xFF8A6BFF); // Violet
  static const _textPrimary = Color(0xFFE6F1FF); // Light Blue
  static const _textSecondary = Color(0xFF94A3B8); // Slate
  static const _borderColor = Color(0xFF2D3A4F); // Border Blue
  static const _cardColor = Color(0xFF152238); // Card Navy

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeAnimations();
    _startTypingAnimation();
    _startMainAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  void _startMainAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  void _startTypingAnimation() {
    Future.delayed(const Duration(milliseconds: 800), () {
      _updateTypingText();
    });
  }

  void _updateTypingText() {
    final targetText = _typingTexts[_typingIndex];

    if (_isDeleting) {
      if (_displayText.isNotEmpty) {
        setState(() {
          _displayText = _displayText.substring(0, _displayText.length - 1);
        });
        _typingTimer = Timer(
          const Duration(milliseconds: 30),
          _updateTypingText,
        );
      } else {
        setState(() {
          _isDeleting = false;
          _typingIndex = (_typingIndex + 1) % _typingTexts.length;
        });
        _typingTimer = Timer(
          const Duration(milliseconds: 200),
          _updateTypingText,
        );
      }
    } else {
      if (_displayText.length < targetText.length) {
        setState(() {
          _displayText = targetText.substring(0, _displayText.length + 1);
        });
        _typingTimer = Timer(
          const Duration(milliseconds: 60),
          _updateTypingText,
        );
      } else {
        _typingTimer = Timer(const Duration(seconds: 2), () {
          setState(() {
            _isDeleting = true;
          });
          _updateTypingText();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // Function to scroll to projects section
  void _scrollToProjects() {
    if (_projectsKey.currentContext != null) {
      Scrollable.ensureVisible(
        _projectsKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor,
      body: Stack(
        children: [
          // Enhanced background
          _buildEnhancedBackground(),
          SingleChildScrollView(
            controller: _scrollController,
            physics: _isFrozen
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            child: Column(
              children: [
                _buildHeroSection(),
                Container(key: _projectsKey, child: const MyHomePage(scale: 1)),

                _buildFooter(),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Hint Text
                AnimatedOpacity(
                  opacity: _showHint ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: AnimatedSlide(
                    offset: _showHint ? Offset.zero : const Offset(0, 0.2),
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Tap to freeze",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                // Attention Animation
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: _showHint ? 1 : 0),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, -6 * value),
                      child: Transform.scale(
                        scale: 1 + (0.08 * value),
                        child: FloatingActionButton(
                          backgroundColor: _accentColor,
                          elevation: 6 + (4 * value),
                          onPressed: () {
                            setState(() {
                              _isFrozen = !_isFrozen;
                              _showHint = false; // STOP hint after interaction
                            });
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              _isFrozen
                                  ? Icons.lock_outline_rounded
                                  : Icons.lock_open_rounded,
                              key: ValueKey(_isFrozen),
                              color: _primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedBackground() {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _primaryColor.withValues(alpha: 0.98),
              _secondaryColor.withValues(alpha: 0.95),
              const Color(0xFF0D1525).withValues(alpha: 0.9),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: CustomPaint(painter: _EnhancedBackgroundPainter()),
      ),
    );
  }

  Widget _buildHeroSection() {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 60 * widget.scale,
                vertical: isMobile ? 40 : 60 * widget.scale,
              ),
              child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Content
        Expanded(child: _buildContentSection()),
        SizedBox(width: 40 * widget.scale),
        // Right Avatar
        Expanded(child: _buildDeveloperAvatar()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildDeveloperAvatar(),
        SizedBox(height: 40 * widget.scale),
        _buildContentSection(),
      ],
    );
  }

  Widget _buildContentSection() {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreeting(),
          SizedBox(height: 8 * widget.scale),
          _buildName(),
          SizedBox(height: 16 * widget.scale),
          _buildTypingText(),
          SizedBox(height: 32 * widget.scale),
          _buildDescription(),
          SizedBox(height: 48 * widget.scale),
          _buildActionButtons(),
          SizedBox(height: 32 * widget.scale),
          _buildTechStack(),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Row(
      children: [
        Container(
          width: 32 * widget.scale,
          height: 1,
          color: _accentColor,
          margin: EdgeInsets.only(right: 12 * widget.scale),
        ),
        Text(
          'HELLO THERE',
          style: TextStyle(
            fontSize: 14 * widget.scale,
            color: _lightAccent,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kundan',
          style: TextStyle(
            fontSize: 56 * widget.scale,
            fontWeight: FontWeight.w800,
            height: 0.9,
            color: _textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [_accentColor, _lightAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            'Kumar',
            style: TextStyle(
              fontSize: 56 * widget.scale,
              fontWeight: FontWeight.w800,
              height: 0.9,
              color: _textPrimary,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypingText() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      decoration: BoxDecoration(
        color: _cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor, width: 1),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20 * widget.scale,
        vertical: 12 * widget.scale,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.code_rounded,
            color: _lightAccent,
            size: 20 * widget.scale,
          ),
          SizedBox(width: 12 * widget.scale),
          Text(
            'I build ',
            style: TextStyle(
              fontSize: 18 * widget.scale,
              color: _textPrimary,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 4 * widget.scale),
          Text(
            _displayText,
            style: TextStyle(
              fontSize: isMobile ? 16 * widget.scale : 18 * widget.scale,
              color: _accentColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 3,
            height: 22 * widget.scale,
            margin: EdgeInsets.only(left: 4 * widget.scale),
            color: _accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.all(24 * widget.scale),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                color: _accentColor,
                margin: EdgeInsets.only(right: 12 * widget.scale),
              ),
              Text(
                'ABOUT ME',
                style: TextStyle(
                  fontSize: 14 * widget.scale,
                  color: _lightAccent,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * widget.scale),
          Text(
            'Flutter developer with 1.5+ years of experience crafting high-performance '
            'cross-platform applications. I specialize in creating elegant solutions '
            'with clean code, modern architecture, and pixel-perfect UIs that deliver '
            'exceptional user experiences.',
            style: TextStyle(
              fontSize: 15 * widget.scale,
              color: _textSecondary,
              height: 1.8,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildButton(
          text: 'Explore More',
          icon: Icons.arrow_outward_rounded,
          isPrimary: false,
          onTap: _scrollToProjects,
        ),
        SizedBox(width: 16 * widget.scale),
        _buildButton(
          text: 'View Resume',
          icon: Icons.description_rounded,
          isPrimary: false,
          onTap: _downloadCV,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 * widget.scale : 32 * widget.scale,
            vertical: isMobile ? 16 * widget.scale : 18 * widget.scale,
          ),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? LinearGradient(
                    colors: [_accentColor, _purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isPrimary ? null : _cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isPrimary ? Colors.transparent : _borderColor,
              width: 1.5,
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: _accentColor.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : _accentColor,
                size: 18 * widget.scale,
              ),
              SizedBox(width: 12 * widget.scale),
              Text(
                text,
                style: TextStyle(
                  fontSize: 15 * widget.scale,
                  color: isPrimary ? Colors.white : _accentColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechStack() {
    final techIcons = [
      Icons.flutter_dash_rounded,
      Icons.mobile_friendly_rounded,
      Icons.cloud_rounded,
      Icons.code_rounded,
      Icons.storage_rounded,
      Icons.security_rounded,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TECH STACK',
          style: TextStyle(
            fontSize: 12 * widget.scale,
            color: _textSecondary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 16 * widget.scale),
        Wrap(
          spacing: 16 * widget.scale,
          runSpacing: 16 * widget.scale,
          children: techIcons.map((icon) {
            return Container(
              width: 40 * widget.scale,
              height: 40 * widget.scale,
              decoration: BoxDecoration(
                color: _cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: _lightAccent, size: 28 * widget.scale),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDeveloperAvatar() {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Transform.scale(
        scale: 1.0 + _controller.value * 0.05,
        child: SizedBox(
          width: 500 * widget.scale,
          height: 500 * widget.scale,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background glow
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _accentColor.withValues(alpha: 0.15),
                        _purpleAccent.withValues(alpha: 0.05),
                        Colors.transparent,
                      ],
                      stops: const [0.1, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              // Orbiting elements
              _buildOrbitingElement(
                angle: _controller.value * 2 * pi,
                distance: 250,
                icon: Icons.flutter_dash_rounded,
                color: _accentColor,
              ),
              _buildOrbitingElement(
                angle: _controller.value * 2 * pi + pi / 3,
                distance: 220,
                icon: Icons.code_rounded,
                color: _lightAccent,
              ),
              _buildOrbitingElement(
                angle: _controller.value * 2 * pi + 2 * pi / 3,
                distance: 180,
                icon: Icons.mobile_screen_share_rounded,
                color: _purpleAccent,
              ),

              // Main avatar container
              Container(
                width: 320 * widget.scale,
                height: 320 * widget.scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_cardColor, _secondaryColor],
                  ),
                  border: Border.all(
                    color: _borderColor.withValues(alpha: 0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: const Offset(0, 20),
                    ),
                    BoxShadow(
                      color: _accentColor.withValues(alpha: 0.2),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Avatar character
                    _buildAvatarCharacter(),

                    // Glasses reflection
                    Positioned(
                      top: 110 * widget.scale,
                      child: Container(
                        width: 200 * widget.scale,
                        height: 4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.05),
                              Colors.transparent,
                            ],
                          ),
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

  Widget _buildOrbitingElement({
    required double angle,
    required double distance,
    required IconData icon,
    required Color color,
  }) {
    final x = cos(angle) * distance;
    final y = sin(angle) * distance;

    return Positioned(
      left: 250 * widget.scale + x,
      top: 250 * widget.scale + y,
      child: Container(
        width: 60 * widget.scale,
        height: 60 * widget.scale,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 24 * widget.scale),
      ),
    );
  }

  Widget _buildAvatarCharacter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Head
        Container(
          width: 120 * widget.scale,
          height: 120 * widget.scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _textPrimary,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _textPrimary.withValues(alpha: 0.9),
                _textPrimary.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glasses
              Positioned(
                top: 40 * widget.scale,
                child: Container(
                  width: 100 * widget.scale,
                  height: 30 * widget.scale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: _accentColor, width: 3),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
              ),

              // Eyes
              Positioned(
                top: 45 * widget.scale,
                left: 30 * widget.scale,
                child: Container(
                  width: 20 * widget.scale,
                  height: 20 * widget.scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _accentColor,
                  ),
                ),
              ),
              Positioned(
                top: 45 * widget.scale,
                right: 30 * widget.scale,
                child: Container(
                  width: 20 * widget.scale,
                  height: 20 * widget.scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _accentColor,
                  ),
                ),
              ),

              // Smile
              Positioned(
                bottom: 35 * widget.scale,
                child: Container(
                  width: 60 * widget.scale,
                  height: 15 * widget.scale,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                      bottom: Radius.circular(20),
                    ),
                    border: Border.all(color: _lightAccent, width: 2),
                    color: _lightAccent.withValues(alpha: 0.1),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20 * widget.scale),

        // Body with laptop
        Container(
          width: 180 * widget.scale,
          height: 120 * widget.scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _secondaryColor,
            border: Border.all(color: _borderColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80 * widget.scale,
                padding: EdgeInsets.all(16 * widget.scale),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: _primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8 * widget.scale,
                          height: 8 * widget.scale,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _lightAccent,
                          ),
                        ),
                        SizedBox(width: 4 * widget.scale),
                        Container(
                          width: 8 * widget.scale,
                          height: 8 * widget.scale,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _accentColor,
                          ),
                        ),
                        SizedBox(width: 4 * widget.scale),
                        Container(
                          width: 8 * widget.scale,
                          height: 8 * widget.scale,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _purpleAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8 * widget.scale),
                    Container(
                      width: 120 * widget.scale,
                      height: 4 * widget.scale,
                      color: _accentColor.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: 4 * widget.scale),
                    Container(
                      width: 80 * widget.scale,
                      height: 4 * widget.scale,
                      color: _lightAccent.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: 4 * widget.scale),
                    Container(
                      width: 100 * widget.scale,
                      height: 4 * widget.scale,
                      color: _purpleAccent.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: _cardColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.keyboard_rounded,
                      color: _textSecondary,
                      size: 32 * widget.scale,
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

  Widget _buildFooter() {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 * widget.scale : 40 * widget.scale,
        vertical: 20 * widget.scale,
      ),

      child: Column(
        children: [
          Divider(color: _borderColor, height: 1),
          SizedBox(height: 16 * widget.scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMobile
                        ? 'CRAFTING DIGITAL\nEXPERIENCES'
                        : 'CRAFTING DIGITAL EXPERIENCES',
                    style: TextStyle(
                      fontSize: 10 * widget.scale,
                      color: _textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 4 * widget.scale),
                  Text(
                    '© ${DateTime.now().year} Kundan Kumar',
                    style: TextStyle(
                      fontSize: 13 * widget.scale,
                      color: _textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.bolt_rounded,
                    color: _lightAccent,
                    size: 14 * widget.scale,
                  ),
                  SizedBox(width: 8 * widget.scale),
                  Text(
                    'Built with passion',
                    style: TextStyle(
                      fontSize: 13 * widget.scale,
                      color: _textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _downloadCV() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResumeScreen()),
    );
  }
}

class _EnhancedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D3A4F).withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // Draw diagonal grid
    final gridSize = 80.0;
    for (double i = -size.height; i < size.width; i += gridSize) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }

    // Draw subtle glow in corners
    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFF00C2FF).withValues(alpha: 0.03),
              Colors.transparent,
            ],
            radius: 300,
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.8, size.height * 0.2),
              radius: 300,
            ),
          );

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      300,
      glowPaint,
    );

    final glowPaint2 = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFF8A6BFF).withValues(alpha: 0.02),
              Colors.transparent,
            ],
            radius: 250,
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.2, size.height * 0.8),
              radius: 250,
            ),
          );

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.8),
      250,
      glowPaint2,
    );

    // Draw minimal dots at intersections
    final dotPaint = Paint()
      ..color = const Color(0xFF5AEDDA).withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    for (double i = gridSize / 2; i < size.width; i += gridSize) {
      for (double j = gridSize / 2; j < size.height; j += gridSize) {
        if (Random().nextDouble() > 0.7) {
          canvas.drawCircle(Offset(i, j), 1.5, dotPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
