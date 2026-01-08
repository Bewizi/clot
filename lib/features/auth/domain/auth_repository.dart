import 'package:clot/features/auth/domain/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });
  Future<AppUser?> signIn({required String email, required String password});
  Future<void> signOut();

  // Add this method
  AppUser? getCurrentUser();

  // Optional: Add auth state stream
  Stream<AppUser?> get authStateChanges;

  Future<void> resetPassword({required String email});

  Future<AppUser?> updateUserProfile({
    required String userId,
    String? gender,
    int? age,
    bool? isProfileComplete,
  });
}
