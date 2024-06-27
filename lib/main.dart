import 'package:blocknet/presentation/authentication/signup.dart';
import 'package:blocknet/presentation/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool hasWallet = prefs.getBool('hasWallet') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn, hasWallet: hasWallet));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool hasWallet;
  const MyApp({super.key,required this.isLoggedIn, required this.hasWallet});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.jetBrainsMono(fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.jetBrainsMono(fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        useMaterial3: true,
      ),
      home: (isLoggedIn&&hasWallet) ? Navigation() : SignUpScreen(),
    );
  }
}
