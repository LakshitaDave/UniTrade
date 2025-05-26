import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smilestone/constants/app_strings.dart';
import 'package:smilestone/custom-widgets/elevated_btn.dart';
import 'package:smilestone/custom-widgets/textformfield.dart';

import '../../Utils/size_config.dart';
import '../../Utils/validation.dart';
import '../../constants/app_colors.dart';

class ForgotPassword extends StatelessWidget {
   ForgotPassword({super.key});

  final _formKey = GlobalKey<FormState>();
   TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Positioned(top: MediaQuery
              .of(context)
              .size
              .height / 14,
              child: Image.asset(
                'lib/assets/app_name.png', width: MediaQuery
                  .of(context)
                  .size
                  .width, )),
        ),

        body: Stack(
          children: [
            Positioned(bottom: 0,child: Image.asset('lib/assets/wave_background.png',width: MediaQuery.of(context).size.width,)),
            Center(
              child: Padding(
                    padding:  EdgeInsets.all(MediaQuery.of(context).size.width/14),
                    child: SingleChildScrollView(
                      child: Column(
      
                        children: [
                            //SizedBox(height: MediaQuery.of(context).size.height/10,),
                            const Text(forgotPwdScreenTitle,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 2),),
                            const Text(forgotPwdScreenText,style: TextStyle(fontSize: 16),),
                            SizedBox(height: MediaQuery.of(context).size.height/26,),
                            Form(
                              key: _formKey,
                              child: Column(
                                  children: [
                                    CustomTextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: 'Email id',
                                      validator:emailValidator,
                                      autoValidateMode: AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      suffix: false,
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.all(MediaQuery.of(context).size.width/10),
                                      child: ElevatedBtn(
                                        btnName: sendCodeButtonText,
                                        onPressed: (){
                                          if(_formKey.currentState!.validate()){
                                            Navigator.pushNamed(context, '/verify');
                                          }
      
                                          },
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
      ),
    );
  }
}
