import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_appbar.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/shop_navbar.dart';

class CreateListingScreen extends StatelessWidget {
  const CreateListingScreen( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CreateListingAppBar(),
        body: CreateListingScreenful(),
        bottomNavigationBar: ShopNavigationBar(),
      ),
    );
  }
}
