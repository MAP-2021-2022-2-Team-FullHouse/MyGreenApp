import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import 'package:mygreenapp/ui/screen/home/home_screenState.dart';
import 'package:mygreenapp/ui/screen/home/widget/logout_button.dart';
import '../home/home_viewmodel.dart';
import '../../ui_utils.dart';

class HomeBody extends StatelessWidget {
  final HomeScreenfulState _state;
  const HomeBody(this._state);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          View<HomeViewmodel>(
            builder: (_, viewmodel) =>
                LogoutButton(viewmodel: viewmodel, state: _state),
          ),
        ],
      ),
    );
  }
}
