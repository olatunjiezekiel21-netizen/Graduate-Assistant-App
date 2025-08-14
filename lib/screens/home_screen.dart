import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color deepPurple = const Color(0xFF6C2786);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Curved header
          Stack(
            children: [
              ClipPath(
                clipper: CurvedHeaderClipper(),
                child: Container(
                  height: 220,
                  color: deepPurple,
                ),
              ),
              Positioned(
                top: 40,
                left: 24,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(
                          'assets/preloader_assets/charco_education.png'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'DADA TIMILEHIN S.',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                right: 24,
                child: Row(
                  children: [
                    Icon(Icons.headphones, color: Colors.white, size: 28),
                    const SizedBox(width: 16),
                    Icon(Icons.notifications, color: Colors.white, size: 28),
                  ],
                ),
              ),
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Graduate Guide',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Main grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildGridItem('assets/preloader_assets/nysc.png',
                        'Nysc Reg.\nGuidelines'),
                    _buildGridItem(
                        'assets/preloader_assets/resume.png', 'Resume Builder'),
                    _buildGridItem(
                        'assets/preloader_assets/task.png', 'Acquire Skill'),
                    _buildGridItem('assets/preloader_assets/masters.png',
                        'Masters Upadate'),
                    _buildGridItem(
                        'assets/preloader_assets/job.png', 'Job Offer'),
                    _buildArrowItem(),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Campus News',
                      style: GoogleFonts.poppins(
                        color: deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'See all >',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/preloader_assets/fmn.png',
                      width: 48,
                      height: 48,
                    ),
                    title: Text(
                      'Lautech Student Emerge as the best in the FMN Competition',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      'Posted 30 min ago',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(deepPurple),
    );
  }

  Widget _buildGridItem(String asset, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(asset, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildArrowItem() {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child:
            const Icon(Icons.arrow_forward_ios, size: 32, color: Colors.grey),
      ),
    );
  }

  Widget _buildBottomNavBar(Color deepPurple) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: deepPurple,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'Updates'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
      ],
      onTap: (index) {
        // Implement navigation if needed
      },
    );
  }
}

// Curved header clipper
class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
