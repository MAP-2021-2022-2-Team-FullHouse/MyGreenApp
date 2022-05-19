import 'package:flutter/material.dart';
import 'package:map_mvvm/view.dart';
import '../../ui_utils.dart';
import 'admin_viewmodel.dart';

class AdminFloat extends StatelessWidget {
  const AdminFloat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AdminViewmodel>(
        shouldRebuild: false, builder: (_, viewmodel) => Container());
  }
}
