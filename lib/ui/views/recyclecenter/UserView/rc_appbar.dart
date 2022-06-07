import 'package:flutter/material.dart';

class RCAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RCAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      elevation: 10,
      automaticallyImplyLeading: false, 
      title: Text("Nearby Recycle Center"),
      centerTitle: true,
    );
  }
}
