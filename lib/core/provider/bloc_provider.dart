import 'package:clot/features/auth/data/firebase_auth_repository.dart';
import 'package:clot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appBlocProvider = [
  BlocProvider(
    create: (context) =>
        AuthBloc(authRepository: FirebaseAuthRepository())
          ..add(AuthStatusChecked()),
  ),
];
