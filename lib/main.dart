import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/screens/home_page.dart';
import 'package:r_connect/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:r_connect/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.redAccent,
      //statusBarIconBrightness: Brightness.dark, // Status bar color
    ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        if(snapshot.hasData) {
          return const HomePageScreeen();
        }
        return const LoginPageScreen();
      })
    );
  }
}
