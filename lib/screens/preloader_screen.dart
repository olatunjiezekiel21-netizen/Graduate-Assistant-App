import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class PreloaderScreen extends StatefulWidget {
  const PreloaderScreen({super.key});

  @override
  State<PreloaderScreen> createState() => _PreloaderScreenState();
}

class _PreloaderScreenState extends State<PreloaderScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;
  int _currentImageIndex = 0;
  final List<String> _preloaderImages = [
    'preloader assets/Preloader1 (1).png',
    'preloader assets/Preloader2 (1).png',
    'preloader assets/Preloader3 (1).png',
    'preloader assets/Preloader4 (1).png',
  ];

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _startPreloader();
  }

  void _startPreloader() {
    _logoController.forward();
    Timer(const Duration(milliseconds: 500), () {
      _textController.forward();
    });
    Timer(const Duration(milliseconds: 1000), () {
      _progressController.forward();
    });

    // Cycle through preloader images
    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (mounted) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % _preloaderImages.length;
        });
      }
    });

    // Navigate to onboarding after 4 seconds
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo
              AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoController.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          _preloaderImages[_currentImageIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(duration: 1.seconds),

              const SizedBox(height: 40),

              // App title
              AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textController.value,
                    child: Text(
                      'Newly Graduate Hub',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade800,
                      ),
                    ),
                  );
                },
              ).animate().slideY(begin: 0.5, end: 0),

              const SizedBox(height: 10),

              AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textController.value,
                    child: Text(
                      'Your journey starts here',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                },
              ).animate().slideY(begin: 0.5, end: 0),

              const SizedBox(height: 60),

              // Progress indicator
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _progressController.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple.shade600,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(delay: 1.seconds),

              const SizedBox(height: 20),

              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _progressController.value,
                    child: Text(
                      'Loading... ${(_progressController.value * 100).toInt()}%',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(delay: 1.seconds),
            ],
          ),
        ),
      ),
    );
  }
}