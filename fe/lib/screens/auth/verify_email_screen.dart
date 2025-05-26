import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smilestone/Utils/size_config.dart';
import 'package:smilestone/constants/app_strings.dart';
import 'package:smilestone/custom-widgets/otp_textformfield.dart';

import '../../constants/app_colors.dart';
import '../../custom-widgets/elevated_btn.dart';

class VerifyEmail extends StatefulWidget {
   VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
   String? _otp;

  final _formKey = GlobalKey<FormState>();

   final TextEditingController _fieldOne = TextEditingController();
   final TextEditingController _fieldTwo = TextEditingController();
   final TextEditingController _fieldThree = TextEditingController();
   final TextEditingController _fieldFour = TextEditingController();


   FocusNode oneNode = FocusNode();
   FocusNode twoNode = FocusNode();
   FocusNode threeNode = FocusNode();
   FocusNode fourNode = FocusNode();

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(top: MediaQuery.of(context).size.height/14,child: Image.asset('lib/assets/background-img.png',width: MediaQuery.of(context).size.width,)),
          Center(
            child: Padding(
              padding:  EdgeInsets.all(MediaQuery.of(context).size.width/14),
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height/6,),
                    const Text(verifyEmailScreenTitle,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 2),),
                    const Text(verifyEmailScreenText,style: TextStyle(fontSize: 16),),
                    SizedBox(height: MediaQuery.of(context).size.height/26,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                
                            children: [
                
                              OTPTextFormField(
                                controller: _fieldOne,
                                index: 0,
                                onFieldSubmittedEvent: () { FocusScope.of(context).requestFocus(twoNode);},
                                onBackspaceEvent: () { _fieldOne.clear(); },
                                focusNode: oneNode,

                              ),
                              OTPTextFormField(
                                controller: _fieldTwo,
                                index: 1,
                                onFieldSubmittedEvent: () { FocusScope.of(context).requestFocus(threeNode);},
                                onBackspaceEvent: () {
                                  if(_fieldTwo.text.isEmpty){
                                    FocusScope.of(context).requestFocus(oneNode);
                                  }
                                  _fieldTwo.clear(); },
                                focusNode: twoNode,
                              ),
                              OTPTextFormField(
                                controller: _fieldThree,
                                index: 2,
                                onFieldSubmittedEvent: () { FocusScope.of(context).requestFocus(fourNode);},
                                onBackspaceEvent: () {

                                  if(_fieldThree.text.isEmpty){
                                    FocusScope.of(context).requestFocus(twoNode);
                                  }
                                  _fieldThree.clear(); },
                                focusNode: threeNode,
                              ),
                              OTPTextFormField(
                                controller: _fieldFour,
                                index: 3,
                                onFieldSubmittedEvent: () {
                                  FocusScope.of(context).unfocus();
                                  if(_fieldOne.text.isEmpty || _fieldTwo.text.isEmpty|| _fieldThree.text.isEmpty || _fieldFour.text.isEmpty) {
                                    const Dialog(
                                      child: Text("enter verification code"),
                                    );
                                  }
                                  },
                                onBackspaceEvent: () {

                                  if(_fieldFour.text.isEmpty){
                                    FocusScope.of(context).requestFocus(threeNode);
                                  }
                                  _fieldFour.clear(); },
                                focusNode: fourNode,
                              ),
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.all(MediaQuery.of(context).size.width/14),
                            child: ElevatedBtn(
                              btnName: verifyOTPButtonText,
                              onPressed: (){
                                setState(() {
                                  _otp = _fieldOne.text +
                                      _fieldTwo.text +
                                      _fieldThree.text +
                                      _fieldFour.text;
                                });
                                Navigator.pushNamed(context, '/reset');
                                },
                              icon: Icons.arrow_forward,
                              bgcolor: greenButtonColor,
                              textStyle: const TextStyle(fontSize: 17),
                            ),
                          ),
                          const Text("Didn't received OTP?",style: TextStyle(fontSize: 20),),
                          TextButton(onPressed: (){}, child: Text("Resend Again",style: TextStyle(color: greenButtonColor,fontSize: 20,fontWeight: FontWeight.bold),))
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
