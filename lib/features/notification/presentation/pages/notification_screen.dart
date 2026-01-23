import 'package:clot/features/navigation/app_nav_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const String routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      bottomNavigationBar: AppNavBar(currentIndex: 1),
      body: const Center(child: Text('This is the notifications screen')),
    );
  }
}
