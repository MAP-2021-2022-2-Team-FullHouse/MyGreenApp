import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/ui/views/shop/shop_screenstate.dart';
import 'package:my_green_app/ui/views/shop/shop_viewmodel.dart';

class ShopButton extends StatelessWidget {
  final ShopViewmodel viewmodel;
  final ShopScreenfulState state;
  final Listing model;
   const ShopButton(
      {Key? key, required this.viewmodel, required this.state, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.whatsapp,
          size: 18.0,
        ),
        label: const Text('Contact Seller'),
        onPressed: () async {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) =>
          //        ChatRoomScreen(userTo:model.sellerID,userToName: model.seller),
          // ));
          state.contactSeller(model);
        },
      ),
      const SizedBox(
        width: 8,
      ),
    ]);
  }
}
