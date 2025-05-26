import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextFormField extends StatelessWidget {
  const OTPTextFormField({super.key, required this.controller, required this.index, required this.onFieldSubmittedEvent, required this.onBackspaceEvent,required this.focusNode});

  final TextEditingController controller ;
  final int index;
  final VoidCallback onFieldSubmittedEvent;
  final VoidCallback onBackspaceEvent;
  final FocusNode focusNode;

  @override
      Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height:50,
              width: 60,
              child: KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace &&
                      controller.text.isEmpty) {
                    onBackspaceEvent();
                  }
                },
                child: TextFormField(
                  controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.center,
                maxLength: 1,
                obscureText: true,
                obscuringCharacter: '*',
                style: const TextStyle(fontSize: 20),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value){
                    if(value.isNotEmpty){
                      onFieldSubmittedEvent();
                    }

                  },
                  onFieldSubmitted: (value){
                    onFieldSubmittedEvent();
                  },


                        decoration: const InputDecoration(
                          counterText: '',
                            enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen,width: 2.0)),
                            focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.lightGreen,width: 2.0)),
                        ),
                    ),
              ),
    )
        );
  }
}
