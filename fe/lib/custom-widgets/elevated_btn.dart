import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {

   ElevatedBtn({super.key,
    this.btnName,
    required this.onPressed,
    this.icon,
    this.textStyle,
    this.bgcolor,
    this.iconColor=Colors.amberAccent,
    this.textColor=Colors.white

      });

  final String? btnName;
  final VoidCallback onPressed;
  final IconData? icon;
  final TextStyle? textStyle;
  final Color? bgcolor;
  final Color? iconColor;
  final Color? textColor;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {onPressed();  },
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor,
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(btnName!,style: TextStyle(fontSize: 21,letterSpacing: 2,color: textColor),),
            ),
            Icon(icon! ,color: iconColor,)
          ],

      ),

    );
  }
}
