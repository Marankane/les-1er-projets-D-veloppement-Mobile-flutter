import 'package:flutter/material.dart';

import 'pages/main_navigation_page.dart';
import 'state/booking_store.dart';
import 'state/favorites_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritesStore.instance.init();
  await BookingStore.instance.init();
  runApp(const BalaguroApp());
}

class BalaguroApp extends StatelessWidget {
  const BalaguroApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color.fromARGB(255, 0, 42, 231);
    const secondary = Color(0xFF5C9EAA);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Balaguro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        fontFamily: 'Poppins',
        textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w700,
          ),
          displayMedium: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w700,
          ),
          displaySmall: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w700,
          ),
          titleLarge: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w600,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w600,
          ),
          titleSmall: const TextStyle(
            fontFamily: 'VisueltPro',
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: const TextStyle(fontFamily: 'Poppins'),
          bodyMedium: const TextStyle(fontFamily: 'Poppins'),
          bodySmall: const TextStyle(fontFamily: 'Poppins'),
          labelLarge: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
          labelMedium: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          labelSmall: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFF2F6FC),
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: primary,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE5ECF5)),
          ),
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF3E6D9C)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle: TextStyle(color: Colors.white),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
      ),
      home: const MainNavigationPage(),
    );
  }
}
