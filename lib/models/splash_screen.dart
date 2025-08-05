import 'dart:async';
import 'package:expenses/expenses_list/my_expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  const SplashScreen({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Expenses(
            onToggleTheme: widget.toggleTheme,
            themeMode: widget.themeMode,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF455a64),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Expenses',
              style: GoogleFonts.pacifico(
                textStyle: const TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/wallet_logo.png', height: 300, width: 300),

            const SizedBox(height: 30),
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: const Color(0xFFEA3799),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
