import 'package:flutter/material.dart';
import 'data/shop_categories.dart';
import 'pages/category_pages.dart';
import 'pages/home_pages.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ToyotaGrApp());
}

class ToyotaGrApp extends StatelessWidget {
  const ToyotaGrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOYOTA GAZOO RACING',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBg,
        fontFamily: 'Segoe UI',
        fontFamilyFallback: const ['Roboto', 'Helvetica', 'Arial'],
        colorScheme: const ColorScheme.dark(
          primary: kRed,
          surface: kSurface,
          onSurface: Color(0xFFF2F4F7),
        ),
        dividerColor: kBorder,
      ),
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  final name = settings.name ?? '/';
  final category = categoryForRoute(name);
  final Widget page = category != null
      ? CategoryPage(category: category)
      : const HomePage();

  return PageRouteBuilder<void>(
    settings: settings,
    pageBuilder: (_, _, _) => page,
    transitionDuration: const Duration(milliseconds: 220),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    transitionsBuilder: (_, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
