import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_body.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_viewmodel.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_screen.dart';

class CreateListingScreenful extends StatefulWidget {
  const CreateListingScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const CreateListingScreenful());

  @override
  State<CreateListingScreenful> createState() => CreateListingScreenfulState();
}

class CreateListingScreenfulState extends State<CreateListingScreenful> {
  CreateListingViewmodel viewmodel=CreateListingViewmodel();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  String currentCategory = 'Computers & Tech';
  String currentMethod = 'Mailing';
  String currentCondition = 'New';

  var categoryList = [
    'Computers & Tech',
    'Mobile Phones & Gadgets',
    'Furniture & Home Living',
    'Woman’s Fashion',
    'Man’s Fashion',
    'Beauty & Personal Care',
    'Others'
  ];
  var methodList = [
    'Mailing',
    'Meet-up',
  ];

  var conditionList = [
    'New',
    'Used',
  ];

  var fileField=TextEditingController();
  String? filename;

  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      viewmodel.setUserEmail();
    });
          
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CreateListingBody(state:this));
  }
  void addListing() async {
    if(currentCategory==""||currentCondition==""||currentMethod=="")
    {
      showConfirmDialog(context, "Please fill in the form completely");
    }
    dynamic result;
    try {
      result = await viewmodel.addListing(
          title: titleController.text,
          category: currentCategory,
          condition: currentCondition,
          image:fileField.text,
          price: priceController.text,
          description: descriptionController.text,
          method: currentMethod,
          );
         
      if (result != null) {
        showConfirmDialog(context, "Created Successfully!");
          
      }
     
    } catch (e) {
      showAlertDialog(context, "Form is not completely filled.$e");
    }
  }
  showConfirmDialog(BuildContext context, String text){
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.homeRoute);
        Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ManageListingScreen(),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Message"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showAlertDialog(BuildContext context, String text) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, routes.createRecycleCenterRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
