// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/screens/welcome_screen.dart';
import 'package:mentoria/providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mentoria App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            // Usa el tema del provider si lo necesitas personalizado
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: WelcomeScreen(),
          );
        },
      ),
    );
  }
}

class HomePage {
  const HomePage();
}

class RegisterPage {
  const RegisterPage();
}

class LoginPage {
  const LoginPage();
}