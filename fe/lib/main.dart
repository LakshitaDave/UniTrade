import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smilestone/categoryList.dart';
import 'package:smilestone/productsubmit.dart';
import 'package:smilestone/screens/auth/forgot_password.dart';
import 'package:smilestone/screens/auth/login_screen.dart';
import 'package:smilestone/screens/auth/reset_password.dart';
import 'package:smilestone/screens/auth/signup_screen.dart';
import 'package:smilestone/screens/auth/verify_email_screen.dart';
import 'package:smilestone/screens/main-screens/home_screen.dart';
import 'package:smilestone/screens/main-screens/welcomeScreen.dart';
import 'package:smilestone/screens/slider/sliderscreen.dart';
import 'package:smilestone/screens/splash.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/splash':(context)=> const SplashScreen(),
        '/slider':(context)=> SliderScreen(),
        '/login':(context)=> const LoginScreen(),
        '/forgotPwd':(context)=> ForgotPassword(),
        '/welcome' :(context)=>const WelcomeScreen(),
        '/signup':(context)=> SignUpScreen(),
        '/verify':(context)=>VerifyEmail(),
        '/reset' : (context)=>ResetPassword(),
        '/home' : (context)=>HomeScreen(),

        '/productform':(context)=>ProductSubmissionScreen(),
        '/categoryList':(context)=>ExploreScreen(),

      },
    );
  }
}

