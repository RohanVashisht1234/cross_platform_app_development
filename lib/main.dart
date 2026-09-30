import 'package:flutter/material.dart';
import 'screens/home_navigation_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local persistent storage service (SharedPreferences)
  final storageService = await StorageService.init();

  runApp(MealCraftApp(storageService: storageService));
}

/// The root application widget for MealCraft.
class MealCraftApp extends StatefulWidget {
  final StorageService storageService;

  const MealCraftApp({super.key, required this.storageService});

  @override
  State<MealCraftApp> createState() => _MealCraftAppState();
}

class _MealCraftAppState extends State<MealCraftApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _updateThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealCraft - Recipe Sharing & Meal Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: HomeNavigationScreen(
        storageService: widget.storageService,
        currentThemeMode: _themeMode,
        onThemeModeChanged: _updateThemeMode,
      ),
    );
  }
}
