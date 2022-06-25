import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/shop_appbar.dart';
import 'package:my_green_app/ui/views/shop/shop_navbar.dart';

class ManageListingScreen extends StatelessWidget {
  const ManageListingScreen( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ShopAppBar(),
        body: ManageListingScreenful(),
        bottomNavigationBar: const ShopNavigationBar(),
      ),
    );
  }
}
