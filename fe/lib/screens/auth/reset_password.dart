import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smilestone/Utils/validation.dart';
import 'package:smilestone/constants/app_strings.dart';
import 'package:smilestone/custom-widgets/textformfield.dart';

import '../../constants/app_colors.dart';
import '../../custom-widgets/elevated_btn.dart';

class ResetPassword extends StatelessWidget {
   ResetPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwdConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(top: MediaQuery.of(context).size.height/14,child: Image.asset('lib/assets/background-img.png',width: MediaQuery.of(context).size.width,)),
          Center(
            child: Padding(
              padding:  EdgeInsets.all(MediaQuery.of(context).size.width/15),
              child: SingleChildScrollView(
                child: Column(
                
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height/7,),
                    const Text(resetPwdScreenTitle,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 2),),
                    const Text(restPwdScreenText,style: TextStyle(fontSize: 16),),
                    SizedBox(height: MediaQuery.of(context).size.height/30,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: pwdController,
                            keyboardType: TextInputType.text,
                            hintText: 'New Password',
                            validator:pwdValidator,
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            suffix: true,
                          ),CustomTextFormField(
                            controller: pwdConfirmController,
                            keyboardType: TextInputType.text,
                            hintText: 'Confirm Password',
                            validator:pwdConfirmValidator,
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            suffix: true,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width/8,),
                          Padding(
                            padding:  EdgeInsets.all(MediaQuery.of(context).size.width/14),
                            child: ElevatedBtn(
                              btnName: 'Reset Password',
                              onPressed: (){Navigator.pushReplacementNamed(context, '/welcome');},
                              icon: Icons.arrow_forward,
                              bgcolor: greenButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/3,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
