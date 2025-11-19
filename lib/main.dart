import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mentoria/screens/welcome_screen.dart';
import 'package:mentoria/providers/theme_provider.dart';
import 'package:mentoria/providers/notifications_provider.dart';
import 'package:mentoria/providers/user_provider.dart'; // <-- agregamos esto

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()), // <-- necesario
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MentoriA',
            theme: themeProvider.themeData,
            darkTheme: themeProvider.themeData,
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}
