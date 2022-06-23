import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_appbar.dart';
import 'package:my_green_app/ui/views/shop/shop_navbar.dart';

class EditListingScreen extends StatelessWidget {
  String docid='';
  EditListingScreen( {Key? key, required this.docid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const EditListingAppBar(),
        body: EditListingScreenful(docid:docid),
        bottomNavigationBar: const ShopNavigationBar(),
      ),
    );
  }
}
