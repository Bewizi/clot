import 'package:clot/features/auth/domain/app_user.dart';
import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<AppUser?> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    try {
      // Create user with Firebase Auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'isProfileComplete': false,
      });

      // Return AppUser object
      final appUser = AppUser(
        id: userCredential.user!.uid,
        firstname: firstname,
        lastname: lastname,
        email: email,
        isProfileComplete: false,
      );

      return appUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<AppUser?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user data from Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      final userData = userDoc.data();

      return AppUser(
        id: userCredential.user!.uid,
        firstname: userData?['firstname'] ?? '',
        lastname: userData?['lastname'] ?? '',
        email: email,
        gender: userData?['gender'],
        age: userData?['age'],
        isProfileComplete: userData?['isProfileComplete'] ?? false,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  // Get current user
  AppUser? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return AppUser(
      id: user.uid,
      firstname: '',
      lastname: '',
      email: user.email ?? '',
      isProfileComplete: false,
    );
  }

  // Listen to auth state changes
  Stream<AppUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return AppUser(
        id: user.uid,
        firstname: '',
        lastname: '',
        email: user.email ?? '',
      );
    });
  }

  // reset password
  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  @override
  Future<AppUser?> updateUserProfile({
    required String userId,
    String? gender,
    int? age,
    bool? isProfileComplete,
  }) async {
    try {
      final Map<String, dynamic> updateData = {};

      if (gender != null) updateData['gender'] = gender;
      if (age != null) updateData['age'] = age;
      if (isProfileComplete != null)
        updateData['isProfileComplete'] = isProfileComplete;

      // update firstore
      await _firestore.collection('users').doc(userId).update(updateData);

      // get updated user data
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data();

      if (userData == null) return null;

      return AppUser(
        id: userId,
        firstname: userData['firstname'] ?? '',
        lastname: userData['lastname'] ?? '',
        email: userData['email'] ?? '',
        gender: userData['gender'],
        age: userData['age'],
        isProfileComplete: userData['isProfileComplete'] ?? false,
      );
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Helper method to handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is invalid.';
      default:
        return e.message ?? 'An authentication error occurred.';
    }
  }
}
