import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/home_screenState.dart';
import 'package:my_green_app/ui/views/recyclecenter_home/home_viewmodel.dart';

class LogoutButton extends StatelessWidget {
  final RecycleCenterHomeViewmodel viewmodel;
  final RecycleCenterHomeScreenfulState state;
  const LogoutButton({required this.viewmodel, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(195, 196, 141, 100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: MaterialButton(
            onPressed: () async {
              state.onLogout(viewmodel);
            },
            child: Text("Logout")));
  }
}
