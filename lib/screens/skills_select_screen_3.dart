import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSelectScreen3 extends StatelessWidget {
  const SkillsSelectScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    final Color deepPurple = const Color(0xFF6C2786);
    final args = ModalRoute.of(context)?.settings.arguments;
    final List<String> selectedSkills = (args is List<String>) ? args : const [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Review Selection', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You selected',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Expanded(
              child: selectedSkills.isEmpty
                  ? Center(
                      child: Text('No skills selected', style: GoogleFonts.poppins(color: Colors.grey)),
                    )
                  : ListView.separated(
                      itemCount: selectedSkills.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          leading: const Icon(Icons.check_circle, color: Colors.green),
                          title: Text(selectedSkills[index], style: GoogleFonts.poppins()),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                },
                child: Text('Finish',
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}