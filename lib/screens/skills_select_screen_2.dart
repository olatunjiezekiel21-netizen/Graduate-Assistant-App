import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSelectScreen2 extends StatefulWidget {
  const SkillsSelectScreen2({super.key});

  @override
  State<SkillsSelectScreen2> createState() => _SkillsSelectScreen2State();
}

class _SkillsSelectScreen2State extends State<SkillsSelectScreen2> {
  final Color deepPurple = const Color(0xFF6C2786);

  late final List<String> categories;
  final Map<String, List<String>> _skillsByCategory = const {
    'Frontend': ['HTML', 'CSS', 'JavaScript', 'React', 'Vue', 'Flutter Web'],
    'Backend': ['Node.js', 'Django', 'Laravel', 'Spring Boot', 'Go'],
    'Mobile': ['Flutter', 'Kotlin', 'Swift', 'React Native'],
    'UI/UX': ['Figma', 'Wireframing', 'Prototyping', 'Design Systems'],
    'Data': ['Python', 'SQL', 'Pandas', 'Power BI', 'TensorFlow'],
    'Cloud': ['AWS', 'GCP', 'Azure', 'Firebase'],
    'Product': ['Product Strategy', 'Roadmapping', 'User Research'],
    'Cybersecurity': ['Network Security', 'Ethical Hacking', 'OWASP'],
    'DevOps': ['Docker', 'Kubernetes', 'CI/CD', 'Terraform'],
  };

  final Set<String> _selectedSkills = <String>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    categories = (args is List<String> && args.isNotEmpty) ? args : <String>['Frontend'];
  }

  void _goNext() {
    Navigator.pushNamed(
      context,
      '/skills/select3',
      arguments: _selectedSkills.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              color: deepPurple,
              child: Center(
                child: Text('Select Skills',
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final category in categories)
                    _buildCategorySection(category, _skillsByCategory[category] ?? const []),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: deepPurple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Back', style: GoogleFonts.poppins(color: deepPurple)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _selectedSkills.isEmpty ? null : _goNext,
                      child: Text('Next',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, List<String> skills) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category,
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final s in skills)
                FilterChip(
                  label: Text(s, style: GoogleFonts.poppins()),
                  selected: _selectedSkills.contains(s),
                  selectedColor: deepPurple.withOpacity(0.15),
                  showCheckmark: true,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        _selectedSkills.add(s);
                      } else {
                        _selectedSkills.remove(s);
                      }
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}