import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_screen.dart';
import 'package:my_green_app/ui/views/shop/shop_screenstate.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/ui/views/shop/shop_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/listinglist.dart';

class ShopBody extends StatefulWidget {
  final ShopScreenfulState state;
  const ShopBody({Key? key, required this.state}) : super(key: key);

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShopViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            ElevatedButton.icon(
              icon: const Icon(
                Icons.list,
                size: 18.0,
              ),
              label: const Text('My Listing'),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ManageListingScreen( ),
                ));
              },
            ),
            const SizedBox(height: 10.00,),
            StreamBuilder<List<Listing>>(
                stream: model.getListingList(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }
                  if (snapshot.hasData) {
                    final listing = snapshot.data!;
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: listing.map(buildListing).toList(),
                    );
                  } else {
                    return const Center(child: Text('No data found'));
                  }
            }),
        ],
        ),),
      ),
      viewModelBuilder: () => ShopViewmodel(),
    );
  }
}
