part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Loading state
final class AuthLoading extends AuthState {}

// Authenticated state (user is logged in)
final class Authenticated extends AuthState {
  final AppUser user;

  Authenticated(this.user);
}

// Unauthenticated state (user is not logged in)
final class Unauthenticated extends AuthState {}

// Error state
final class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

final class PasswordResetEmailSent extends AuthState {
  final String email;

  PasswordResetEmailSent(this.email);
}

final class ProfileUpdatd extends AuthState {
  final AppUser user;

  ProfileUpdatd(this.user);
}
