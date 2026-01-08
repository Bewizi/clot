import 'package:clot/core/navigation/router.dart';
import 'package:clot/core/presentation/theme/app_theme.dart';
import 'package:clot/core/provider/bloc_provider.dart';
import 'package:clot/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appBlocProvider,
      child: MaterialApp.router(
        theme: AppThemeData.lightTheme,
        routerConfig: appRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
