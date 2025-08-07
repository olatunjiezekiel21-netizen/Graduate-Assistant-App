import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    required String name,
    required String phone,
    required String gender,
    required String university,
    required String graduationYear,
    required String course,
    String? profileImage,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'phone': phone,
          'gender': gender,
          'university': university,
          'graduation_year': graduationYear,
          'course': course,
        },
      );

      if (response.user != null) {
        // Insert user profile data
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'name': name,
          'phone': phone,
          'gender': gender,
          'university': university,
          'graduation_year': graduationYear,
          'course': course,
          'profile_image_url': profileImage,
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
      final response = await _supabase.auth.signInWithPassword(
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

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return response;
    } catch (e) {
      print('Get user profile error: $e');
      return null;
    }
  }

  Future<bool> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      await _supabase
          .from('profiles')
          .update({
            ...data,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
      return true;
    } catch (e) {
      print('Update user profile error: $e');
      return false;
    }
  }

  Future<String?> updateProfileImage(String userId, String imageUrl) async {
    try {
      await _supabase
          .from('profiles')
          .update({
            'profile_image_url': imageUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
      return imageUrl;
    } catch (e) {
      print('Update profile image error: $e');
      return null;
    }
  }

  Stream<AuthState> authStateChanges() {
    return _supabase.auth.onAuthStateChange;
  }
} 