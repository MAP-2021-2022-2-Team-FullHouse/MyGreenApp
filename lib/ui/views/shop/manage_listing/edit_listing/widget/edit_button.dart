import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screenstate.dart';

class EditButton extends StatelessWidget {
  final EditListingScreenfulState state;

 const EditButton({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(195, 196, 141, 100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: MaterialButton(
            onPressed: () => {state.editListing()}, child: const Text("Edit")));
  }
}
