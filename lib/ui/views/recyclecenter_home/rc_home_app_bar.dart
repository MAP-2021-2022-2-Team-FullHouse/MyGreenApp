import 'package:flutter/material.dart';

class RecycleCenterHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RecycleCenterHomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      elevation: 10,
      automaticallyImplyLeading: false,
      title: Image.asset(
        "assets/logo.png",
        height: 100,
      ),
      centerTitle: true,
    );
  }
}
