import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'admin_viewmodel.dart';

class AdminFloat extends StatelessWidget {
  const AdminFloat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminViewmodel>.reactive(
      /* shouldRebuild: false, */ builder: (context, viewmodel, child) =>
          Container(),
      viewModelBuilder: () => AdminViewmodel(),
    );
  }
}
