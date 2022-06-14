import 'package:flutter/material.dart';

class RecycleCenterAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RecycleCenterAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      elevation: 10,
      automaticallyImplyLeading: false,
      title: const Text("Manage Recycle Center"),
      centerTitle: true,
    );
  }
}
