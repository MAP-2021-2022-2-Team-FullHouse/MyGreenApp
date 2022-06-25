import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screen.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_viewmodel.dart';

class ManageListingButton extends StatelessWidget {
  final ManageListingViewmodel viewmodel;
  final ManageListingScreenfulState state;
  final Listing model;
   const ManageListingButton(
      {Key? key, required this.viewmodel, required this.state, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ElevatedButton.icon(
        icon: const Icon(
          Icons.edit,
          size: 18.0,
        ),
        label: const Text('Edit'),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                 EditListingScreen(docid:model.documentId),
          ));
        },
      ),
      const SizedBox(
        width: 8,
      ),
      ElevatedButton.icon(
        icon: const Icon(
          Icons.delete,
          size: 18.0,
        ),
        label: const Text('Delete'),
        onPressed: () async {
          state.onDelete(viewmodel, model.documentId);
        },
      ),
    ]);
  }
}
