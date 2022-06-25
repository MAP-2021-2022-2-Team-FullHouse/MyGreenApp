import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/widget/create_button.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_screenstate.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_textfield.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/widget/create_pic.dart';
import 'package:stacked/stacked.dart';

class CreateListingBody extends StatefulWidget {
  final CreateListingScreenfulState state;
  const CreateListingBody({Key? key, required this.state}) : super(key: key);

  @override
  State<CreateListingBody> createState() => _CreateListingBodyState();
}

class _CreateListingBodyState extends State<CreateListingBody> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateListingViewmodel>.reactive(
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
                      ...buildCreateTextFields(widget.state),
                      UploadPicture(state: widget.state),
                      const SizedBox(height: 10.0),
                      CreateButton(state: widget.state),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CreateListingViewmodel(),
    );
  }
}
