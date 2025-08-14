import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Color deepPurple = const Color(0xFF6C2786);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _middleNameRightController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Dropdown values
  String? _selectedNationality;
  String? _selectedSchool;
  DateTime? _selectedDob;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Sample data (can be moved to a constants file or fetched later)
  static const List<String> _nationalities = <String>[
    'Nigeria',
    'Ghana',
    'Kenya',
    'South Africa',
    'United Kingdom',
    'United States',
  ];

  static const List<String> _schools = <String>[
    'Ladoke Akintola University of Technology (LAUTECH)',
    'University of Lagos (UNILAG)',
    'University of Ibadan (UI)',
    'University of Nigeria (UNN)',
    'Ahmadu Bello University (ABU Zaria)',
    'Covenant University',
    'Babcock University',
    'Federal Polytechnic Offa',
  ];

  @override
  void dispose() {
    _surnameController.dispose();
    _middleNameRightController.dispose();
    _middleNameController.dispose();
    _usernameController.dispose();
    _ninController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Surname & Middle Name (inline)
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFormField(
                            controller: _surnameController,
                            label: 'Surname',
                            validator: _requireText,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextFormField(
                            controller: _middleNameRightController,
                            label: 'Middle Name',
                            validator: _requireText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Middle Name (single per design)
                    _buildTextFormField(
                      controller: _middleNameController,
                      label: 'Middle Name',
                      validator: _requireText,
                    ),
                    const SizedBox(height: 16),

                    // User Name
                    _buildTextFormField(
                      controller: _usernameController,
                      label: 'User Name',
                      validator: _requireText,
                    ),
                    const SizedBox(height: 16),

                    // Nationality & Birth date
                    Row(
                      children: [
                        Expanded(
                          child: _buildNationalityDropdown(),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDatePickerField(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // School Attended & NIN NO.
                    Row(
                      children: [
                        Expanded(
                          child: _buildSchoolDropdown(),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextFormField(
                            controller: _ninController,
                            label: 'NIN NO.',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'NIN is required';
                              }
                              final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
                              if (digitsOnly.length < 8) {
                                return 'Enter a valid NIN';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Mobile Number with flag-like leading box
                    Text('Mobile Number', style: GoogleFonts.poppins(fontSize: 15)),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 6, height: 18, color: const Color(0xFF0B8D19)),
                              const SizedBox(width: 4),
                              Container(width: 6, height: 18, color: const Color(0xFF0B8D19)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildTextFormField(
                            controller: _phoneController,
                            label: '+234',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Phone is required';
                              }
                              final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                              if (digits.length < 10) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Password and Confirm Password
                    _buildTextFormField(
                      controller: _passwordController,
                      label: 'Create Password',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextFormField(
                      controller: _confirmPasswordController,
                      label: 'Re-enter Password',
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _requireText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: GoogleFonts.poppins(fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildNationalityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedNationality,
      decoration: InputDecoration(
        hintText: 'Select Nationality',
        hintStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: _nationalities
          .map((nation) => DropdownMenuItem<String>(
                value: nation,
                child: Text(nation, style: GoogleFonts.poppins(fontSize: 14)),
              ))
          .toList(),
      onChanged: (value) => setState(() => _selectedNationality = value),
      validator: (value) => value == null ? 'Select nationality' : null,
    );
  }

  Widget _buildSchoolDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedSchool,
      decoration: InputDecoration(
        hintText: '-select option-',
        hintStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: _schools
          .map((school) => DropdownMenuItem<String>(
                value: school,
                child: Text(school, style: GoogleFonts.poppins(fontSize: 14)),
              ))
          .toList(),
      onChanged: (value) => setState(() => _selectedSchool = value),
      validator: (value) => value == null ? 'Select school' : null,
    );
  }

  Widget _buildDatePickerField() {
    return TextFormField(
      controller: _dobController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: _dobController.text.isEmpty ? '01 / 11 / 2000' : _dobController.text,
        hintStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black54),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, size: 20),
          onPressed: _pickDob,
        ),
      ),
      validator: (value) {
        if (_selectedDob == null) {
          return 'Select date of birth';
        }
        final sixteenYearsAgo = DateTime(DateTime.now().year - 16, DateTime.now().month, DateTime.now().day);
        if (_selectedDob!.isAfter(sixteenYearsAgo)) {
          return 'Must be at least 16 years old';
        }
        return null;
      },
    );
  }

  Future<void> _pickDob() async {
    final DateTime today = DateTime.now();
    final DateTime initial = DateTime(today.year - 24, today.month, today.day);
    final DateTime first = DateTime(today.year - 80, 1, 1);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDob ?? initial,
      firstDate: first,
      lastDate: today,
      helpText: 'Select date of birth',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: deepPurple),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDob = picked;
        _dobController.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    final String dd = date.day.toString().padLeft(2, '0');
    final String mm = date.month.toString().padLeft(2, '0');
    final String yyyy = date.year.toString();
    return '$dd / $mm / $yyyy';
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() != true) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Registration details are valid. Implement backend next.',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: deepPurple,
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
