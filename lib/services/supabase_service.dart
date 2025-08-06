import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class SupabaseService {
  static const String _supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String _supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  late SupabaseClient _supabase;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
    _supabase = Supabase.instance.client;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
    File? profileImage,
  }) async {
    try {
      // Create user account
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Upload profile image if provided
        String? imageUrl;
        if (profileImage != null) {
          final String fileName = '${response.user!.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final String filePath = 'profile_images/$fileName';
          
          await _supabase.storage
              .from('avatars')
              .upload(filePath, profileImage);
          
          imageUrl = _supabase.storage
              .from('avatars')
              .getPublicUrl(filePath);
        }

        // Create user profile
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'email': email,
          'name': userData['name'],
          'phone': userData['phone'],
          'gender': userData['gender'],
          'university': userData['university'],
          'graduation_year': userData['graduation_year'],
          'course': userData['course'],
          'avatar_url': imageUrl,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        return true;
      }
      return false;
    } catch (e) {
      print('Sign up error: $e');
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user != null;
    } catch (e) {
      print('Sign in error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = getCurrentUser();
      if (user == null) return null;

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return response;
    } catch (e) {
      print('Get user profile error: $e');
      return null;
    }
  }

  Future<bool> updateUserProfile(Map<String, dynamic> data) async {
    try {
      final user = getCurrentUser();
      if (user == null) return false;

      await _supabase
          .from('profiles')
          .update({
            ...data,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id);

      return true;
    } catch (e) {
      print('Update user profile error: $e');
      return false;
    }
  }

  Future<bool> updateProfileImage(File imageFile) async {
    try {
      final user = getCurrentUser();
      if (user == null) return false;

      final String fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = 'profile_images/$fileName';
      
      await _supabase.storage
          .from('avatars')
          .upload(filePath, imageFile);
      
      final String imageUrl = _supabase.storage
          .from('avatars')
          .getPublicUrl(filePath);

      await _supabase
          .from('profiles')
          .update({
            'avatar_url': imageUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id);

      return true;
    } catch (e) {
      print('Update profile image error: $e');
      return false;
    }
  }

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
} 