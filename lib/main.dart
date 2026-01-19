import 'package:flutter/material.dart';
import 'core/routes.dart';

void main() {
  runApp(const SimukaApp());
}

class SimukaApp extends StatelessWidget {
  const SimukaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMUKA',
      debugShowCheckedModeBanner: false,

      // Routing
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,

      // Theme 
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F8FF),
        primaryColor: const Color(0xFF5B8DEF),
      ),
    );
  }
}
