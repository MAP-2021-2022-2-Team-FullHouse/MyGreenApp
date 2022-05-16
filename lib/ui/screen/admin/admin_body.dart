import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:mygreenapp/ui/screen/admin/admin_screenstate.dart';
import 'package:mygreenapp/ui/screen/admin/widget/logoutbutton.dart';
import '../admin/admin_viewmodel.dart';
import '../../ui_utils.dart';

class AdminBody extends StatelessWidget {
  final AdminScreenfulState _state;
  const AdminBody(this._state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          View<AdminViewmodel>(
            builder: (_, viewmodel) =>
                LogoutButton(viewmodel: viewmodel, state: _state),
          ),
        ],
      ),
    );
  }
}
