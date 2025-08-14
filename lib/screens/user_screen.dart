import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color deepPurple = const Color(0xFF6C2786);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Stack(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(color: deepPurple),
                ),
                // Decorative rectangles
                Positioned(top: 120, left: -20, child: Image.asset('pages assets/Rectangle 42.png', width: 160)),
                Positioned(top: 120, right: -20, child: Image.asset('pages assets/Rectangle 43.png', width: 160)),
                Positioned(
                  top: 16,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 24,
                  child: Row(
                    children: [
                      Image.asset('pages assets/Customer care (1).png', width: 24, height: 24),
                      const SizedBox(width: 12),
                      Image.asset('pages assets/Bell.png', width: 20, height: 20),
                    ],
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white,
                        child: Image.asset('pages assets/UserCircle.png', width: 56, height: 56),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dada',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Timilehin Silvanus',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'LAUTECH GRADUATE',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // User details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildInfoRow('Gender', 'Male'),
                  _buildInfoRow('Course of Study', 'Animal Sci.'),
                  _buildInfoRow('Birth date', 'March 17'),
                  _buildInfoRow('NIN', 'timi001@gmail.com'),
                  _buildInfoRow('Mobile No.', '+234809012345'),
                  _buildInfoRow('Nationality', 'NIGERIAN'),
                  _buildInfoRow('School Attended', 'Lautech'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/skill-progress'),
                      child: Text(
                        'Skill acquisition Progress',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
      bottomNavigationBar: _buildBottomNavBar(context, deepPurple),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.grey[800],
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, Color deepPurple) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: deepPurple,
      unselectedItemColor: Colors.grey,
      currentIndex: 3,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'Updates'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/messages');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/updates');
            break;
          case 3:
            break;
        }
      },
    );
  }
}
