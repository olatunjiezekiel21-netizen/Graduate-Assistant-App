import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newly_graduate_hub/services/supabase_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final Color deepPurple = const Color(0xFF6C2786);
  String? _avatarUrl;
  bool _isUploading = false;

  Future<void> _changeAvatar() async {
    try {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(source: ImageSource.gallery, maxWidth: 512);
      if (picked == null) return;
      setState(() => _isUploading = true);
      final Uint8List data = await picked.readAsBytes();

      final user = SupabaseService().getCurrentUser();
      final String path = user != null
          ? 'avatars/${user.id}.png'
          : 'avatars/guest_${DateTime.now().millisecondsSinceEpoch}.png';

      final String? publicUrl = await SupabaseService().uploadAvatarBytes(data, path, contentType: 'image/png');
      if (!mounted) return;
      setState(() {
        _avatarUrl = publicUrl;
        _isUploading = false;
      });

      if (user != null && publicUrl != null) {
        await SupabaseService().updateProfileImage(user.id, publicUrl);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile image updated', style: GoogleFonts.poppins(color: Colors.white)), backgroundColor: deepPurple),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update image', style: GoogleFonts.poppins(color: Colors.white)), backgroundColor: Colors.red),
      );
    }
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
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.white,
                            backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
                            child: _avatarUrl == null
                                ? Image.asset('pages assets/UserCircle.png', width: 56, height: 56)
                                : null,
                          ),
                          InkWell(
                            onTap: _isUploading ? null : _changeAvatar,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: _isUploading
                                  ? const Padding(
                                      padding: EdgeInsets.all(6),
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Icon(Icons.camera_alt, size: 18, color: Colors.black54),
                            ),
                          ),
                        ],
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
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))]),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(icon: Image.asset('pages assets/Home (1).png', width: 22, height: 22), label: 'Home'),
          BottomNavigationBarItem(icon: Image.asset('pages assets/Annotation.png', width: 22, height: 22), label: 'Messages'),
          BottomNavigationBarItem(icon: Image.asset('pages assets/Speakerphone.png', width: 22, height: 22), label: 'Updates'),
          BottomNavigationBarItem(icon: Image.asset('pages assets/UserCircle.png', width: 22, height: 22), label: 'Me'),
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
      ),
    );
  }
}
