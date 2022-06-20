import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/shop_appbar.dart';
import 'package:my_green_app/ui/views/shop/shop_navbar.dart';
import 'package:my_green_app/ui/views/shop/shop_screenstate.dart';

class ShopScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const ShopScreen());
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ShopAppBar(),
        body: ShopScreenful(),
        bottomNavigationBar: const ShopNavigationBar(),
      ),
    );
  }
}
