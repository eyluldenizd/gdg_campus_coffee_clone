import 'package:flutter/material.dart';
import 'package:gdg_campus_coffee/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDFBF7), // Light cream background
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4E342E), // Deep brown/espresso
          primary: const Color(0xFF4E342E),
          secondary: const Color(0xFFD4A373), // Caramel/amber accent
          surface: Colors.white,
          onSurface: const Color(0xFF3E2723), // Dark text
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4E342E),
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFD4A373).withOpacity(0.3),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(color: Color(0xFF4E342E), fontWeight: FontWeight.bold);
            }
            return const TextStyle(color: Colors.grey);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFF4E342E));
            }
            return const IconThemeData(color: Colors.grey);
          }),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
