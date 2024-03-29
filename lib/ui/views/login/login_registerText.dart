import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/register/register_screen.dart';
import 'package:my_green_app/ui/views/reset/reset_screen.dart';

class LoginRegisterText extends StatelessWidget {
  const LoginRegisterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 10.0,
      ),
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResetScreen()),
            );
          },
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Forgot Password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 10,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  )))),
      SizedBox(
        height: 5.0,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterScreen()),
          );
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Do not have an account? Sign up",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 10,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
    ]);
  }
}
