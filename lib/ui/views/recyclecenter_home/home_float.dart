import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class RecycleCenterHomeFloat extends StatelessWidget {
  const RecycleCenterHomeFloat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecycleCenterHomeViewmodel>.reactive(
      /* shouldRebuild: false, */ builder: (context, viewmodel, child) =>
          Container(),
      viewModelBuilder: () => RecycleCenterHomeViewmodel(),
    );
  }
}
