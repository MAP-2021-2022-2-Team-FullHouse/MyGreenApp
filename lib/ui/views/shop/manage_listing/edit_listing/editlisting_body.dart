import 'package:flutter/material.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/widget/edit_button.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_textfield.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/widget/edit_pic.dart';
import 'package:stacked/stacked.dart';

class EditListingBody extends StatefulWidget {
  final EditListingScreenfulState state;
  const EditListingBody({Key? key, required this.state}) : super(key: key);

  @override
  State<EditListingBody> createState() => _EditListingBodyState();
}

class _EditListingBodyState extends State<EditListingBody> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditListingViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(209, 239, 181, 100),
                  Color.fromRGBO(211, 250, 214, 100)
                ]),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10.0,),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(16.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ] 
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5.0,),
                      FutureBuilder<Listing?>(
                          future: model.readListing(EditListingViewmodel.docid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Something went wrong'));
                            }
                            if (snapshot.hasData) {
                              final listing = snapshot.data!;
                              return Wrap(
                                  children: buildEditTextFields(widget.state, listing));
                            } else {
                              return const Center(child: Text('No data found'));
                            }
                          }),
                      
                      //...buildEditTextFields(widget.state),
                      EditPicture(state: widget.state),
                      const SizedBox(height: 10.0),
                      EditButton(state: widget.state),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => EditListingViewmodel(),
    );
  }
}
