import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ResumeBuilderScreen extends StatefulWidget {
  const ResumeBuilderScreen({super.key});

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  String _selectedTemplate = 'Modern';
  String _selectedColor = 'Blue';
  bool _isGenerating = false;

  final List<String> _templates = [
    'Modern',
    'Professional',
    'Creative',
    'Minimal',
    'Classic',
  ];

  final List<String> _colors = [
    'Blue',
    'Green',
    'Purple',
    'Orange',
    'Red',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Resume Builder',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            onPressed: () {
              // TODO: Preview resume
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Download resume
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with resume builder image
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/pages_items/resume.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8)),

            const SizedBox(height: 24),

            Text(
              'Create Professional Resume',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 8),

            Text(
              'Choose a template and customize your resume to stand out to employers.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 32),

            // Template selection
            Text(
              'Choose Template',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ).animate().fadeIn(delay: 600.ms),

            const SizedBox(height: 16),

            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _templates.length,
                itemBuilder: (context, index) {
                  final template = _templates[index];
                  final isSelected = template == _selectedTemplate;
                  
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTemplate = template;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.shade100 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue.shade600 : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'pages assets/3dicons-file-text-dynamic-color.png',
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              template,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.blue.shade600 : Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ).animate().fadeIn(delay: 800.ms),

            const SizedBox(height: 24),

            // Color selection
            Text(
              'Choose Color Theme',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ).animate().fadeIn(delay: 1000.ms),

            const SizedBox(height: 16),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _colors.map((color) {
                final isSelected = color == _selectedColor;
                final colorValue = _getColorValue(color);
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: colorValue,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.grey.shade800 : Colors.transparent,
                        width: isSelected ? 3 : 0,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 24)
                        : null,
                  ),
                );
              }).toList(),
            ).animate().fadeIn(delay: 1200.ms),

            const SizedBox(height: 32),

            // Resume sections
            Text(
              'Resume Sections',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ).animate().fadeIn(delay: 1400.ms),

            const SizedBox(height: 16),

            _buildSectionCard(
              'Personal Information',
              Icons.person,
              Colors.blue,
              'Add your name, contact details, and summary',
            ).animate().fadeIn(delay: 1600.ms),

            _buildSectionCard(
              'Education',
              Icons.school,
              Colors.green,
              'Add your academic background and achievements',
            ).animate().fadeIn(delay: 1800.ms),

            _buildSectionCard(
              'Experience',
              Icons.work,
              Colors.orange,
              'Add your work experience and responsibilities',
            ).animate().fadeIn(delay: 2000.ms),

            _buildSectionCard(
              'Skills',
              Icons.psychology,
              Colors.purple,
              'Add your technical and soft skills',
            ).animate().fadeIn(delay: 2200.ms),

            _buildSectionCard(
              'Projects',
              Icons.folder,
              Colors.red,
              'Add your projects and achievements',
            ).animate().fadeIn(delay: 2400.ms),

            const SizedBox(height: 32),

            // Generate button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : _generateResume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isGenerating
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Generate Resume',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ).animate().fadeIn(delay: 2600.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, Color color, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.shade400,
            size: 16,
          ),
        ],
      ),
    );
  }

  Color _getColorValue(String colorName) {
    switch (colorName) {
      case 'Blue':
        return Colors.blue.shade600;
      case 'Green':
        return Colors.green.shade600;
      case 'Purple':
        return Colors.purple.shade600;
      case 'Orange':
        return Colors.orange.shade600;
      case 'Red':
        return Colors.red.shade600;
      default:
        return Colors.blue.shade600;
    }
  }

  void _generateResume() {
    setState(() {
      _isGenerating = true;
    });

    // Simulate resume generation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Resume generated successfully with ${_selectedTemplate} template and ${_selectedColor} theme!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }
}