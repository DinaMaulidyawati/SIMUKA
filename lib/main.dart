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
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
