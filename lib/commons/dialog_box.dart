
// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {

  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack, {super.key});
  TextStyle textStyle = const TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child:  AlertDialog(
      title: Text(title,style: textStyle,),
      content: Text(content, style: textStyle,),
      actions: <Widget>[
        TextButton(
          child: const Text("Continue"),
           onPressed: () {
            continueCallBack();
          },
        ),
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      ));
  }
}