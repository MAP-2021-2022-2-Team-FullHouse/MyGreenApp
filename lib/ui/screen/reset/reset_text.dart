import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mygreenapp/ui/screen/reset/reset_screen.dart';

class ResetText extends StatelessWidget {
  const ResetText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        child: Text(
          "Enter your registered email and we'll send you an email to reset your password.",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ]);
  }
}
