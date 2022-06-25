import 'package:flutter/material.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopAppBar({
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
      title: const Text("Second Hand Shop"),
      centerTitle: true,
    );
  }
}
