import 'package:ayurveda/controllers/patient_list_provider.dart';
import 'package:ayurveda/core/themes/app_theme.dart';
import 'package:ayurveda/routes/routes.dart';
import 'package:ayurveda/views/spalsh_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatientListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/',
        routes: Routes.routes,
        home: const SplashWrapper(),
      ),
    );
  }
}
