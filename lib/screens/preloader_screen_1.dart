import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreloaderScreen1 extends StatelessWidget {
  const PreloaderScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final Color deepPurple = const Color(0xFF6C2786);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Skip button
            Positioned(
              top: 16,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                    color: deepPurple,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Illustration
                Center(
                  child: Image.asset(
                    'assets/preloader_assets/charco_education.png',
                    width: 220,
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Graduate guide is an application design to assist graduate to navigate their next stage of their life.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                // Progress indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(deepPurple, true),
                    _buildDot(deepPurple.withOpacity(0.3), false),
                    _buildDot(deepPurple.withOpacity(0.15), false),
                    _buildDot(deepPurple.withOpacity(0.15), false),
                  ],
                ),
                const SizedBox(height: 32),
                // Next button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/preloader2');
                      },
                      child: Text(
                        'NEXT',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(Color color, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 16,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
