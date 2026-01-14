// router.dart
import 'dart:async';

import 'package:clot/features/auth/presentation/forgot_password/forgot_password.dart';
import 'package:clot/features/auth/presentation/forgot_password/reset_password.dart';
import 'package:clot/features/auth/presentation/sign_in/sign_in.dart';
import 'package:clot/features/auth/presentation/sign_up/sign_up.dart';
import 'package:clot/features/auth/presentation/tell_us_about_yourself/tell_us_about_yourself.dart';
import 'package:clot/features/home/presentation/home.dart';
import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/presentation/accessories.dart';
import 'package:clot/features/products/presentation/category_product.dart';
import 'package:clot/features/products/presentation/hoodies.dart';
import 'package:clot/features/products/presentation/shop_by_categories.dart';
import 'package:clot/features/splashscreen/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRoute = GoRouter(
  initialLocation: SplashScreen.routeName,
  redirect: (context, state) async {
    final user = FirebaseAuth.instance.currentUser;
    final currentLocation = state.matchedLocation;

    // Define auth routes
    final isAuthRoute =
        currentLocation == SignIn.routeName ||
        currentLocation == SignUp.routeName ||
        currentLocation == ForgotPassword.routeName ||
        currentLocation == SplashScreen.routeName ||
        currentLocation == ResetPassword.routeName;

    final isOnboardingRoute = currentLocation == TellUsAboutYourself.routeName;

    // If user is logged in
    if (user != null) {
      // Check if user has completed profile
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        final isProfileComplete = userDoc.data()?['isProfileComplete'] ?? false;

        // If profile is not complete and not on onboarding page, redirect to onboarding
        if (!isProfileComplete && !isOnboardingRoute) {
          return TellUsAboutYourself.routeName;
        }

        // If profile is complete and on onboarding page, redirect to home
        if (isProfileComplete && isOnboardingRoute) {
          return HomePage.routeName;
        }

        // Allow access to onboarding page if profile is incomplete
        if (isOnboardingRoute && !isProfileComplete) {
          return null;
        }

        // If trying to access auth pages, redirect to home (profile already complete)
        if (isAuthRoute && currentLocation != SplashScreen.routeName) {
          return HomePage.routeName;
        }
      } catch (e) {
        print('Error checking profile status: $e');
        throw Exception('Error checking profile status: $e');
      }
    }

    // If user is NOT logged in
    if (user == null) {
      // If trying to access protected pages, redirect to sign up
      if (!isAuthRoute) {
        return SignUp.routeName;
      }
    }

    return null;
  },
  refreshListenable: GoRouterRefreshStream(
    FirebaseAuth.instance.authStateChanges(),
  ),
  routes: [
    GoRoute(
      path: SignIn.routeName,
      name: 'signIn',
      builder: (context, state) => const SignIn(),
    ),
    GoRoute(
      path: SignUp.routeName,
      name: 'signUp',
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: ForgotPassword.routeName,
      name: 'forgotPassword',
      builder: (context, state) => const ForgotPassword(),
    ),
    GoRoute(
      path: ResetPassword.routeName,
      name: 'resetPassword',
      builder: (context, state) => const ResetPassword(),
    ),
    GoRoute(
      path: TellUsAboutYourself.routeName,
      name: 'tellUsAboutYourself',
      builder: (context, state) => const TellUsAboutYourself(),
    ),
    GoRoute(
      path: SplashScreen.routeName,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: HomePage.routeName,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: ShopByCategories.routeName,
      name: 'shopByCategories',
      builder: (context, state) => const ShopByCategories(),
    ),

    GoRoute(
      path: Hoodies.routeName,
      name: 'hoodies',
      builder: (context, state) => const Hoodies(),
    ),

    GoRoute(
      path: Accessories.routeName,
      name: 'accessories',
      builder: (context, state) => const Accessories(),
    ),

    GoRoute(
      path: CategoryProduct.routeName,
      name: 'categoryProduct',
      builder: (context, state) {
        final category = state.extra as Category;

        return CategoryProduct(category: category);
      },
    ),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  late final Stream<dynamic> stream;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
