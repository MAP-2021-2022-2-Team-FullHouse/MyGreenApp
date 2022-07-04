import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/ui/views/shop/shop_body.dart';
import 'package:my_green_app/ui/views/shop/shop_viewmodel.dart';

class ShopScreenful extends StatefulWidget {
  const ShopScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const ShopScreenful());

  @override
  State<ShopScreenful> createState() => ShopScreenfulState();
}

class ShopScreenfulState extends State<ShopScreenful> {
  ShopViewmodel viewmodel=ShopViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ShopBody(state:this));
  }
  Future<String?> getImgUrl(String imgUrl) async {
    return await viewmodel.getImgUrl(imgUrl);
  }

  Future contactSeller(Listing model) async
  {
    viewmodel.contactSeller(model);
  }
}
