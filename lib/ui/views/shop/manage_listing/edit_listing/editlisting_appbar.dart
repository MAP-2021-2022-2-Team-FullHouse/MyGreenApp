import 'package:flutter/material.dart';

class EditListingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditListingAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      elevation: 10,
      title: const Text("Edit Listing"),
      centerTitle: true,
    );
  }
}
