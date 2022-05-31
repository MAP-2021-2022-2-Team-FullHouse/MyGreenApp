import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeFloat extends StatelessWidget {
  const HomeFloat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      /* shouldRebuild: false, */ builder: (context, viewmodel, child) =>
          Container(),
      viewModelBuilder: () => HomeViewmodel(),
    );
  }
}
