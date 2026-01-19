import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase Terhubung");
  } catch (e) {
    print("❌ Firebase Error: $e");
  }

  runApp(const SimukaApp());
}

class SimukaApp extends StatelessWidget {
  const SimukaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIMUKA',
      debugShowCheckedModeBanner: false,
      // Menggunakan initialRoute dan routes secara konsisten
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F3FA),
        primaryColor: const Color(0xFF395886),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF395886),
          primary: const Color(0xFF395886),
        ),
      ),
    );
  }
}