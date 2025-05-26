
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smilestone/constants/app_strings.dart';
import 'package:smilestone/custom-widgets/elevated_btn.dart';

import '../../constants/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Stack(
        children: [
          Positioned(top: MediaQuery.of(context).size.height/14,child: Image.asset('lib/assets/background-img.png',width: MediaQuery.of(context).size.width,)),
          Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/5.5,),
                const Text(welcomeScreenTitle,style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,letterSpacing: 2),),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(welcomeScreenText,style: TextStyle(fontSize: 17,letterSpacing: 1),),
                ),
                Padding(
                  padding:  const EdgeInsets.all(25.0),
                  child: Image.asset('lib/assets/welcome-screen-img.png',height: MediaQuery.of(context).size.height/4,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                Padding(
                  padding:  EdgeInsets.all(MediaQuery.of(context).size.width/10),
                  child: ElevatedBtn(
                    btnName: welcomeScreenButtonText,
                    bgcolor: greenButtonColor,
                    onPressed: (){
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                    icon: Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          )

        ],
      )

    );
  }
}
