import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_screen.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/listinglist.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/shop_screen.dart';
import 'package:stacked/stacked.dart';

import '../../../../model/listing.dart';

class ManageListingBody extends StatefulWidget {
  final ManageListingScreenfulState state;
  const ManageListingBody({Key? key, required this.state}) : super(key: key);

  @override
  State<ManageListingBody> createState() => _ManageListingBodyState();
}

class _ManageListingBodyState extends State<ManageListingBody> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageListingViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Row(
                children: [
                  BackButton(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ShopScreen(),
                      ));
                    },
                  ),
                  const Text(
                    "My Listing", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    const SizedBox(width: 25,),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_circle,
                      size: 18.0,
                    ),
                    label: const Text('Add Listing'),
                    onPressed: () async {
                       Navigator.of(context).push(MaterialPageRoute(
                         builder: (context) =>
                             const CreateListingScreen(),
                       ));
                    },
                  ),
                ],
              ),
            const SizedBox(height:10),
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
          ),
        ),
      ),
      viewModelBuilder: () => ManageListingViewmodel(),
    );
  }
}
