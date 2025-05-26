import 'package:flutter/material.dart';

import '../constants/app_colors.dart';



class CustomTextFormField extends StatefulWidget {
   CustomTextFormField({super.key,
    required this.controller,
     this.autofocus = true,
    required this.keyboardType,
    required this.hintText,
    required this.validator,
    this.icon,
     required this.obscureText,
     this.labelText,
    required this.autoValidateMode,
     required this.suffix});

  final TextEditingController controller;
  final bool autofocus;
  final TextInputType keyboardType;
  final String hintText;
  final FormFieldValidator validator;
  final IconData? icon;
     bool obscureText;
  final String? labelText;
  final AutovalidateMode autoValidateMode;
  final bool suffix;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      autovalidateMode: widget.autoValidateMode,
      textAlign: TextAlign.start,
      //autofocus: autofocus,
      decoration: InputDecoration(
        suffix: widget.suffix ? SizedBox(height: 50,
          child: IconButton(onPressed: (){
            setState(() {
              widget.obscureText =!widget.obscureText;
            });

          }, icon:  Icon(widget.obscureText ? Icons.visibility_off : Icons.visibility)),
        ) : SizedBox(height: 40,),
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixStyle: TextStyle(fontSize: 20),
        enabledBorder:const UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen,width: 2.0)),
        focusedBorder:const UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen,width: 2.0)),
      ),
    );
  }
}
