import 'package:flutter/material.dart';

import 'package:mygreenapp/ui/screen/reset/reset_screen.dart';
import 'package:mygreenapp/ui/screen/reset/widget/reset_textfield.dart';

List<Widget> buildResetTextFields(ResetScreenState state) => [
      ResetTextField(
        controller: state.emailController,
        hintText: "Email",
        iconName: Icons.email_outlined,
        autoCorrect: false,
        keyboard: TextInputType.emailAddress,
      ),
      SizedBox(
        height: 35.0,
      ),
    ];
