import 'package:flutter/material.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/home/home_page.dart';

class AppRoutes {
  static const login = '/';
  static const home = '/home';

  static Map<String, WidgetBuilder> routes = {
    login: (_) => LoginPage(),
    home: (_) => HomePage(),
  };
}
