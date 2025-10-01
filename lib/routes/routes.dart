import 'package:ayurveda/presentation/pages/login_screen.dart';
import 'package:ayurveda/presentation/pages/patientList/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/login': (context) => LoginScreen(),
    '/home' : (context) => HomeScreen(),

  };
}
