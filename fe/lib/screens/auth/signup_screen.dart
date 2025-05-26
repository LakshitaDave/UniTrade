
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smilestone/Utils/app_functions.dart';
import 'package:smilestone/constants/app_strings.dart';

import '../../Utils/validation.dart';
import '../../constants/app_colors.dart';
import '../../custom-widgets/elevated_btn.dart';
import '../../custom-widgets/textformfield.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController pwdConfirmController = TextEditingController();


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
        Positioned(bottom:0,child: Image.asset('lib/assets/wave_background.png',width: MediaQuery.of(context).size.width,)),
        Center(
          child: Padding(
          padding:  EdgeInsets.all(MediaQuery.of(context).size.width/14),
          child: SingleChildScrollView(
          child: Column(
          children: [
            const Text(signupScreenTitle,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,letterSpacing: 2),),
            const Text(signupScreenText,style: TextStyle(fontSize: 15),),
            //SizedBox(height: MediaQuery.of(context).size.height/30,),
            Form(
            key: _formKey,
            child: Column(
            children: [
              CustomTextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                hintText: 'First Name*',
                validator:nameValidator,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscureText: false,
                suffix: false,
              ),CustomTextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.text,
                hintText: 'Last Name',
                validator: lastNameValidator,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscureText: false,
                suffix: false,
              ),CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email id*',
                validator:emailSignUpValidator,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscureText: false,
                suffix: false,
              ),
              CustomTextFormField(
                controller: pwdController,
                keyboardType: TextInputType.text,
                obscureText: true,
                hintText: 'Password*',
                validator: pwdValidator,
                suffix: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
      
              ),CustomTextFormField(
                controller: pwdConfirmController,
                keyboardType: TextInputType.text,
                obscureText: true,
                hintText: 'Password Confirm*',
                validator: pwdConfirmValidator,
                suffix: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
      
              ),
              Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.width/14),
                child: ElevatedBtn(
                  btnName: 'Sign Up',
                  onPressed: (){
                    if(_formKey.currentState!.validate()) Navigator.pushReplacementNamed(context, '/home');},
                  icon: Icons.arrow_forward,
                  bgcolor: greenButtonColor,
                ),
              ),
      
          ],
      
          ),
      ),
            SizedBox(height: MediaQuery.of(context).size.height /20,),
            const Text('Or Continue With',style: TextStyle(fontSize: 18),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const IconButton(onPressed: signInWithGoogle, icon: ImageIcon(AssetImage('lib/assets/google-logo.png'))),
                const IconButton(onPressed: signInWithFacebook, icon: ImageIcon(AssetImage('lib/assets/facebook-logo.png'))),
                IconButton(onPressed: (){}, icon: const ImageIcon(AssetImage('lib/assets/apple-logo.png'))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?',style: TextStyle(fontSize: 18),),
                TextButton(onPressed: (){Navigator.pushNamed(context, '/login');},
                    child: Text('Sign In',style:TextStyle(color: greenButtonColor,fontSize: 20),))
              ],
            ),
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
