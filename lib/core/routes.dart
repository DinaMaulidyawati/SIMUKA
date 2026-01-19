import 'package:flutter/material.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/home/home_page.dart';
import '../presentation/pages/auth/signup_page.dart';

class AppRoutes {
  static const login = '/';
  static const home = '/home';
  static const signup = '/signup';

  static Map<String, WidgetBuilder> routes = {
    // SEMUA KATA 'const' DI BAWAH INI TELAH DIHAPUS UNTUK MEMPERBAIKI ERROR
    login: (context) => LoginPage(), 
    home: (context) => HomePage(),
    signup: (context) => SignUpPage(), 
  };
}