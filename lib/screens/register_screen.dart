import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color deepPurple = const Color(0xFF6C2786);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Curved header with gradient and register icon
            Stack(
              children: [
                ClipPath(
                  clipper: CurvedHeaderClipper(),
                  child: Container(
                    height: 220,
                    color: deepPurple,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/pages_items/register_gradient.png',
                            fit: BoxFit.cover,
                            height: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'New User Form\nKindly fill appropriately',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 32,
                  child: Image.asset(
                    'assets/pages_items/register.png',
                    width: 120,
                    height: 120,
                  ),
                ),
              ],
            ),
            // Form fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Surname & Middle Name
                  Row(
                    children: [
                      Expanded(child: _buildTextField('Surname')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTextField('Middle Name')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Middle Name (again, if needed)
                  _buildTextField('Middle Name'),
                  const SizedBox(height: 16),
                  // User Name
                  _buildTextField('User Name'),
                  const SizedBox(height: 16),
                  // Nationality & Birth date
                  Row(
                    children: [
                      Expanded(
                          child: _buildDropdownField('Select Nationality')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildDateField('01 / 11 / 2000')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // School Attended & NIN NO.
                  Row(
                    children: [
                      Expanded(child: _buildDropdownField('-select option-')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTextField('NIN NO.')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Mobile Number with flag
                  Text('Mobile Number',
                      style: GoogleFonts.poppins(fontSize: 15)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/pages_items/nigeria_flag.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: _buildTextField('+234', prefix: false)),
                    ],
                  ),
                  // Add more fields as needed...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool prefix = true}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 15),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          hint: Text(
            hint,
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black54),
          ),
          items: [],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildDateField(String date) {
    return TextField(
      enabled: false,
      decoration: InputDecoration(
        hintText: date,
        hintStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black54),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: Icon(Icons.calendar_today, size: 20),
      ),
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
