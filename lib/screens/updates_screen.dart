import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  final List<UpdateItem> _updates = [
    UpdateItem(
      title: 'New Course Available',
      description: 'Advanced Web Development course is now live',
      time: '2 hours ago',
      type: UpdateType.course,
      isRead: false,
    ),
    UpdateItem(
      title: 'Job Opportunity',
      description: 'Frontend Developer position at TechCorp',
      time: '1 day ago',
      type: UpdateType.job,
      isRead: false,
    ),
    UpdateItem(
      title: 'Skill Assessment',
      description: 'Your JavaScript skills improved by 15%',
      time: '2 days ago',
      type: UpdateType.skill,
      isRead: true,
    ),
    UpdateItem(
      title: 'Resume Review',
      description: 'Your resume has been reviewed by our experts',
      time: '3 days ago',
      type: UpdateType.resume,
      isRead: true,
    ),
    UpdateItem(
      title: 'Masters Program',
      description: 'New postgraduate opportunities available',
      time: '1 week ago',
      type: UpdateType.masters,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Updates',
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
            icon: const Icon(Icons.mark_email_read),
            onPressed: () {
              setState(() {
                for (var update in _updates) {
                  update.isRead = true;
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with updates image
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Stay Updated',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Get the latest updates on courses, jobs, and opportunities',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/pages_items/task.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _updates.length,
              itemBuilder: (context, index) {
                final update = _updates[index];
                return _buildUpdateCard(update).animate().fadeIn(
                  delay: Duration(milliseconds: index * 100),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateCard(UpdateItem update) {
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
              color: _getUpdateColor(update.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getUpdateIcon(update.type),
              color: _getUpdateColor(update.type),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        update.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: update.isRead ? FontWeight.w500 : FontWeight.w600,
                          color: update.isRead ? Colors.grey.shade700 : Colors.grey.shade800,
                        ),
                      ),
                    ),
                    if (!update.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  update.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  update.time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade500,
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

  Color _getUpdateColor(UpdateType type) {
    switch (type) {
      case UpdateType.course:
        return Colors.blue;
      case UpdateType.job:
        return Colors.green;
      case UpdateType.skill:
        return Colors.orange;
      case UpdateType.resume:
        return Colors.purple;
      case UpdateType.masters:
        return Colors.teal;
    }
  }

  IconData _getUpdateIcon(UpdateType type) {
    switch (type) {
      case UpdateType.course:
        return Icons.school;
      case UpdateType.job:
        return Icons.work;
      case UpdateType.skill:
        return Icons.psychology;
      case UpdateType.resume:
        return Icons.description;
      case UpdateType.masters:
        return Icons.school;
    }
  }
}

class UpdateItem {
  final String title;
  final String description;
  final String time;
  final UpdateType type;
  bool isRead;

  UpdateItem({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.isRead,
  });
}

enum UpdateType {
  course,
  job,
  skill,
  resume,
  masters,
}