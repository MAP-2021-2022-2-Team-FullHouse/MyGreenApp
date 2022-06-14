import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/admin/admin_screenstate.dart';
import 'package:my_green_app/ui/views/admin/widget/logoutbutton.dart';
import 'package:stacked/stacked.dart';
import '../admin/admin_viewmodel.dart';

class AdminBody extends StatelessWidget {
  final AdminScreenfulState _state;
  const AdminBody(this._state);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Admin Home Page"),
              ViewModelBuilder<AdminViewmodel>.reactive(
                builder: (context, viewmodel, child) =>
                    LogoutButton(viewmodel: viewmodel, state: _state),
                viewModelBuilder: () => AdminViewmodel(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AdminViewmodel(),
    );
  }
}
