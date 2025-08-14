import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSelectScreen1 extends StatefulWidget {
  const SkillsSelectScreen1({super.key});

  @override
  State<SkillsSelectScreen1> createState() => _SkillsSelectScreen1State();
}

class _SkillsSelectScreen1State extends State<SkillsSelectScreen1> {
  final Color deepPurple = const Color(0xFF6C2786);

  final List<String> _categories = const [
    'Frontend',
    'Backend',
    'Mobile',
    'UI/UX',
    'Data',
    'Cloud',
    'Product',
    'Cybersecurity',
    'DevOps',
  ];

  final Set<String> _selected = <String>{};

  void _goNext() {
    Navigator.pushNamed(
      context,
      '/skills/select2',
      arguments: _selected.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Stack(
              children: [
                Container(height: 180, color: deepPurple),
                Positioned(
                  top: 16,
                  left: 12,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 24,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Acquire Skill',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('Select area(s) you want to focus on',
                          style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.85), fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose Categories',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _categories.map((c) {
                      final bool isSelected = _selected.contains(c);
                      return ChoiceChip(
                        label: Text(c, style: GoogleFonts.poppins()),
                        selected: isSelected,
                        selectedColor: deepPurple.withOpacity(0.15),
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected ? deepPurple : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              _selected.add(c);
                            } else {
                              _selected.remove(c);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
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
                          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                          child: Text('Skip', style: GoogleFonts.poppins(color: deepPurple)),
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
                          onPressed: _selected.isEmpty ? null : _goNext,
                          child: Text('Next',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}