import 'package:clot/core/navigation/router.dart';
import 'package:clot/core/presentation/theme/app_theme.dart';
import 'package:clot/core/provider/bloc_provider.dart';
import 'package:clot/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(enabled: true, builder: (context) => const MyApp()),
    // MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appBlocProvider,
      child: MaterialApp.router(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: AppThemeData.lightTheme,
        routerConfig: appRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
