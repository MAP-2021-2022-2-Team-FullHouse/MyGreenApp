import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_viewmodel.dart'
    as viewmodel;
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_button.dart';

ManageListingScreenfulState state = ManageListingScreenfulState();

Widget buildListing(Listing listing) => Column(
  children:[ 
    Row(
    children: [
      const SizedBox(width: 10,height: 10,),
      Expanded(
        // height: 150.00,
        // width: 125.00,
        flex: 2,
        child: FutureBuilder(
          future: state.getImgUrl("listing/${listing.documentId}.jpg"),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
              return Container(
              child: buildImage(snapshot.data),
              );
          },
        ),
      ),
      const SizedBox(width: 10,height: 10,),

      Expanded(
        flex: 3,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Text(listing.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(listing.category),
          Text("RM ${listing.price}"),
          Text("Condition: ${listing.condition}"),
          Text("Dealing Method: ${listing.method}"),
          Text("Description: ${listing.description}"),
          ManageListingButton(
            viewmodel: viewmodel.ManageListingViewmodel(),
            model: listing,
            state: ManageListingScreenfulState(),
          )
        ],
      ),
      ),
      const SizedBox(width: 10,height: 10,),

      
      
    ],
  ),
  const SizedBox(width: 10,height: 25,),
  ],
    );

Widget buildImage(String? data) {
  return ClipRect(
    child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: NetworkImage(data.toString()),
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: const InkWell(/* onTap: onClicked */),
      ),
    ),
  );
}
