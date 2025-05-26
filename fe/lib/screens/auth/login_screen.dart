import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smilestone/Utils/validation.dart';
import 'package:smilestone/constants/app_colors.dart';
import 'package:smilestone/constants/app_strings.dart';
import 'package:smilestone/custom-widgets/textformfield.dart';

import '../../Utils/app_functions.dart';
import '../../custom-widgets/elevated_btn.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
    storedCredentialsCheck();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  String? storedEmail;
  late String? storedPwd;

  storedCredentialsCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedEmail = prefs.getString("userEmail");
    storedPwd = prefs.getString("password");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Center(child: Text("UniTrade",style: TextStyle(
              fontSize: 30,color: greenButtonColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),)),
          // title: Positioned(top: MediaQuery
          //     .of(context)
          //     .size
          //     .height / 14,
          //     child: Image.asset(
          //       'lib/assets/app_name.png', width: MediaQuery
          //         .of(context)
          //         .size
          //         .width, )),
        ),
          body: Stack(
              children: [
                Positioned(bottom: 0.0,
                    child: Image.asset(
                      'lib/assets/wave_background.png', width: MediaQuery
                        .of(context)
                        .size
                        .width, )),
                Center(
                    child: Padding(
                      padding: EdgeInsets.all(MediaQuery
                          .of(context)
                          .size
                          .width / 14),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(loginScreenTitle, style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),),
                            const Text(
                              loginScreenText, style: TextStyle(fontSize: 16),),
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .height / 26,),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: 'Enter your email id',
                                      validator: emailValidator,
                                      autoValidateMode: AutovalidateMode
                                          .onUserInteraction,
                                      obscureText: false,
                                      suffix: false,
                                    ),
                                    CustomTextFormField(
                                      controller: pwdController,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      hintText: 'Password',
                                      validator: loginPwdValidator,
                                      suffix: true,
                                      autoValidateMode: AutovalidateMode
                                          .onUserInteraction,

                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/forgotPwd');
                                          },
                                          child: const Text('Forgot Password?',
                                            style: TextStyle(
                                                color: Colors.black),),),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(MediaQuery
                                          .of(context)
                                          .size
                                          .width / 14),
                                      child: ElevatedBtn(
                                        btnName: 'Login',
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            saveCredentials();
                                            Navigator.pushReplacementNamed(
                                                context, '/home');
                                          }
                                        },
                                        icon: Icons.arrow_forward,
                                        bgcolor: greenButtonColor,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .height / 10,),
                            const Text('Or Continue With',
                              style: TextStyle(fontSize: 18),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const IconButton(onPressed: signInWithGoogle,
                                    icon: ImageIcon(AssetImage(
                                        'lib/assets/google-logo.png'))),
                                const IconButton(onPressed: signInWithFacebook,
                                    icon: ImageIcon(AssetImage(
                                        'lib/assets/facebook-logo.png'))),
                                IconButton(onPressed: () {},
                                    icon: const ImageIcon(AssetImage(
                                        'lib/assets/apple-logo.png'))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'New Here?', style: TextStyle(fontSize: 18),),
                                TextButton(onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                    child: Text('Sign Up', style: TextStyle(
                                        color: greenButtonColor, fontSize: 20),))
                              ],
                            ),

                          ],

                        ),
                      ),
                    )
                )
              ]
          )

      ),
    );
  }

  Future<void> saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userEmail", emailController.text);
    prefs.setString("password", pwdController.text);

    emailController.clear();
    pwdController.clear();
  }

}



