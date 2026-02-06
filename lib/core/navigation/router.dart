// router.dart
import 'dart:async';

import 'package:clot/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:clot/features/auth/presentation/pages/forgot_password/reset_password.dart';
import 'package:clot/features/auth/presentation/pages/sign_in/sign_in.dart';
import 'package:clot/features/auth/presentation/pages/sign_up/sign_up.dart';
import 'package:clot/features/auth/presentation/pages/tell_us_about_yourself/tell_us_about_yourself.dart';
import 'package:clot/features/cart/presentation/pages/cart_page.dart';
import 'package:clot/features/cart/presentation/pages/checkout_page.dart';
import 'package:clot/features/cart/presentation/pages/successful_order.dart';
import 'package:clot/features/home/presentation/pages/home.dart';
import 'package:clot/features/notification/presentation/pages/notification_screen.dart';
import 'package:clot/features/orders/presentation/pages/order_details_screen.dart';
import 'package:clot/features/orders/presentation/pages/order_screen.dart';
import 'package:clot/features/products/domain/category.dart';
import 'package:clot/features/products/presentation/pages/category_product.dart';
import 'package:clot/features/products/presentation/pages/products_screen.dart';
import 'package:clot/features/products/presentation/pages/shop_by_categories.dart';
import 'package:clot/features/profile/presentation/pages/address/add_address.dart';
import 'package:clot/features/profile/presentation/pages/address/address.dart';
import 'package:clot/features/profile/presentation/pages/payment/add_card.dart';
import 'package:clot/features/profile/presentation/pages/payment/payment.dart';
import 'package:clot/features/profile/presentation/pages/profile_screen.dart';
import 'package:clot/features/profile/presentation/pages/wishlist/wishlist_screen.dart';
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
        if (!isProfileComplete && !isOnboardingRoute && !isAuthRoute) {
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
    // signIn screen
    GoRoute(
      path: SignIn.routeName,
      name: 'signIn',
      builder: (context, state) => const SignIn(),
    ),

    // signUp screen
    GoRoute(
      path: SignUp.routeName,
      name: 'signUp',
      builder: (context, state) => const SignUp(),
    ),

    // forgotPassword screen
    GoRoute(
      path: ForgotPassword.routeName,
      name: 'forgotPassword',
      builder: (context, state) => const ForgotPassword(),
    ),

    // resetPassword screen
    GoRoute(
      path: ResetPassword.routeName,
      name: 'resetPassword',
      builder: (context, state) => const ResetPassword(),
    ),

    // tellUsAboutYourself screen
    GoRoute(
      path: TellUsAboutYourself.routeName,
      name: 'tellUsAboutYourself',
      builder: (context, state) => const TellUsAboutYourself(),
    ),

    // splash screen
    GoRoute(
      path: SplashScreen.routeName,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // homePage screen
    GoRoute(
      path: HomePage.routeName,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),

    // shopByCategories screen
    GoRoute(
      path: ShopByCategories.routeName,
      name: 'shopByCategories',
      builder: (context, state) => const ShopByCategories(),
    ),

    // category screen
    GoRoute(
      path: CategoryProduct.routeName,
      name: 'categoryProduct',
      builder: (context, state) {
        final category = state.extra as Category;

        return CategoryProduct(category: category);
      },
    ),

    // notifications screen
    GoRoute(
      path: NotificationScreen.routeName,
      name: 'notifications',
      builder: (context, state) => const NotificationScreen(),
    ),

    // order screen
    GoRoute(
      path: OrderScreen.routeName,
      name: 'order',
      builder: (context, state) => const OrderScreen(),
    ),

    // order details screen
    GoRoute(
      path: OrderDetailsScreen.routeName,
      name: 'order-details',
      builder: (context, state) => const OrderDetailsScreen(),
    ),

    // products screen
    GoRoute(
      path: ProductsScreen.routeName,
      name: 'products',
      builder: (context, state) => const ProductsScreen(),
    ),

    // cart screen
    GoRoute(
      path: CartPage.routeName,
      name: 'add-to-cart',
      builder: (context, state) => const CartPage(),
    ),

    // checkout screen
    GoRoute(
      path: CheckoutPage.routeName,
      name: 'checkout-product',
      builder: (context, state) => const CheckoutPage(),
    ),

    // successful order
    GoRoute(
      path: SuccessfulOrder.routeName,
      name: 'successful_order',
      builder: (context, state) => const SuccessfulOrder(),
    ),

    // profile screen
    GoRoute(
      path: ProfileScreen.routeName,
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
      routes: [
        GoRoute(
          path: Address.routeName,
          name: 'address',
          builder: (context, state) => Address(),
          routes: [
            GoRoute(
              path: AddAddress.routeName,
              name: 'add-address',
              builder: (context, state) => AddAddress(),
            ),
          ],
        ),
        GoRoute(
          path: Payment.routeName,
          name: 'payment',
          builder: (context, state) => const Payment(),
          routes: [
            GoRoute(
              path: AddCard.routeName,
              name: 'add-card',
              builder: (context, state) => AddCard(),
            ),
          ],
        ),
        GoRoute(
          path: WishList.routeName,
          name: 'wishlist',
          builder: (context, state) => WishList(),
        ),
      ],
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
