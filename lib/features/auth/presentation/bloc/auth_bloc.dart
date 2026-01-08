import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clot/features/auth/data/firebase_auth_repository.dart';
import 'package:clot/features/auth/domain/app_user.dart';
import 'package:clot/features/auth/domain/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    // Handle Sign Up
    on<SignUpRequested>(_onSignUpRequested);

    // Handle Sign In
    on<SignInRequested>(_onSignInRequested);

    // Handle Sign Out
    on<SignOutRequested>(_onSignOutRequested);

    // Handle Auth Status Check
    on<AuthStatusChecked>(_onAuthStatusChecked);

    // Handle Reset Password
    on<PasswordResetRequested>(_onResetPasswordRequested);

    on<UpdateUserProfileRequested>(_onUpdateUserProfileRequested);
  }

  // Sign Up Handler
  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.signUp(
        firstname: event.firstname,
        lastname: event.lastname,
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Failed to create account'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign In Handler
  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(AuthError('Failed to sign in'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign Out Handler
  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _authRepository.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Check Auth Status Handler
  Future<void> _onAuthStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = (_authRepository as FirebaseAuthRepository).getCurrentUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onResetPasswordRequested(
    PasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.resetPassword(email: event.email);
      emit(PasswordResetEmailSent(event.email));
    } catch (e) {
      AuthError(e.toString());
    }
  }

  Future<void> _onUpdateUserProfileRequested(
    UpdateUserProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final updatedUser = await _authRepository.updateUserProfile(
        userId: event.userId,
        gender: event.gender,
        age: event.age,
        isProfileComplete: true,
      );

      if (updatedUser != null) {
        emit(ProfileUpdatd(updatedUser));

        emit(Authenticated(updatedUser));
      } else {
        emit(AuthError('Failed to update profile'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
