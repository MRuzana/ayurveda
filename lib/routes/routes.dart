import 'package:ayurveda/views/home_screen.dart';
import 'package:ayurveda/views/login_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/login': (context) => LoginScreen(),
    '/home' : (context) => HomeScreen(),

  };
}
