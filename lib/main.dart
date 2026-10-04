import 'package:flutter/material.dart';
import 'package:movie_app/style/colors.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/screens/search_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: AppColors.background,
  ));
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        // Ohne eigenes Farbschema nimmt Flutter Lila als Standard, z. B. für
        // den Textcursor und den Ladekreis. Hier überall das Türkis der App.
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const SearchPage(),
    );
  }
}
