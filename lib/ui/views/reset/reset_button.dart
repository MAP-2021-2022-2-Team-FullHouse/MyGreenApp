import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/reset/reset_screen.dart';
import 'package:my_green_app/ui/views/reset/reset_viewmodel.dart';

class ResetButton extends StatelessWidget {
  final ResetViewmodel viewmodel;
  final ResetScreenState state;
  const ResetButton({super.key, required this.viewmodel, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(195, 196, 141, 100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: MaterialButton(
            onPressed: () async {
              state.resetPassword(viewmodel);
            },
            child: const Text("Reset Password")));
  }
}
