part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// Sign Up Event
class SignUpRequested extends AuthEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  SignUpRequested({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}

// Sign In Event
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
}

// Sign Out Event
class SignOutRequested extends AuthEvent {}

// Check Auth Status Event (when app starts)
class AuthStatusChecked extends AuthEvent {}

class PasswordResetRequested extends AuthEvent {
  final String email;

  PasswordResetRequested({required this.email});
}

class UpdateUserProfileRequested extends AuthEvent {
  final String userId;
  final String? gender;
  final int? age;

  UpdateUserProfileRequested({
    required this.userId,
    required this.gender,
    required this.age,
  });
}
