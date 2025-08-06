import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class PreloaderScreen3 extends StatefulWidget {
  const PreloaderScreen3({super.key});

  @override
  State<PreloaderScreen3> createState() => _PreloaderScreen3State();
}

class _PreloaderScreen3State extends State<PreloaderScreen3>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;

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

    // Navigate to next preloader after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/preloader4');
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
              Colors.orange.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo with slide effect
              AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 20 * (1 - _logoController.value)),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'preloader assets/Preloader3 (1).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(duration: 1.seconds).then().slideY(begin: 0.3, end: 0),

              const SizedBox(height: 40),

              // App title with flip animation
              AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textController.value,
                    child: Text(
                      'Connecting Services',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  );
                },
              ).animate().flip(direction: Axis.horizontal),

              const SizedBox(height: 10),

              AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textController.value,
                    child: Text(
                      'Setting up your personalized experience',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                },
              ).animate().flip(direction: Axis.horizontal),

              const SizedBox(height: 60),

              // Progress indicator with elastic effect
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
                          color: Colors.orange.shade600,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(delay: 1.seconds).then().elastic(),

              const SizedBox(height: 20),

              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _progressController.value,
                    child: Text(
                      'Connecting... ${(_progressController.value * 100).toInt()}%',
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