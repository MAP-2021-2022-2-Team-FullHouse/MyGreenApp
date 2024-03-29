import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screen.dart';
import 'create_recycle_center.dart';

class CreateRecycleCenterScreen extends StatefulWidget {
  const CreateRecycleCenterScreen({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const CreateRecycleCenterScreen());

  @override
  CreateRecycleCenterScreenState createState() => CreateRecycleCenterScreenState();
}

class CreateRecycleCenterScreenState extends State<CreateRecycleCenterScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailField = TextEditingController();
  final phoneField = TextEditingController();
  final addrsField = TextEditingController();
  var latField=TextEditingController();
  var lonField=TextEditingController();
  var fileField=TextEditingController();
  bool _showPassword = false;
  String? filename;
  CreateRecycleCenter_ViewModel viewmodel = CreateRecycleCenter_ViewModel();
  get showPassword => _showPassword;
  set showPassword(value) => setState(() => _showPassword = value);


 
   void addRecycleCenter() async {

    dynamic result;
    try {
      result = await viewmodel.addRecycleCenter(
          name: nameController.text,
          address: addrsField.text,
          phone: phoneField.text,
          image:fileField.text,
          email: emailField.text,
          lat:double.parse(latField.text),
          lon:double.parse(lonField.text),
         
          password: passwordController.text,
          );
         
      if (result != null) {
        if (result == 'Email is registered.') {
         
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Email is registered.");
        } else if (result == "weak-password") {
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Weak password");
        } else if (result == 'invalid-email') {
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Invalid email address.");
        }else if(result=="Name duplicated"){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "This recycle center name is already registered.");
        }else if(result=="Image duplicated"){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "This image is already uploaded.");
        }
        else if(result=="Phone duplicated"){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "This phone is already registered.");
        }
        else if(result=="Form is not completely filled."){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Form is not completely filled.");
        }
        else if(result=="Invalid email format."){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Invalid email format.");
        }
        else if(result=="Invalid phone format."){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Invalid phone format.");
        }
        else if(result=="Password too short."){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Password too short.");
        }
        else {
          // ignore: use_build_context_synchronously
          showConfirmDialog(context, "Created Successfully!");
          
        }
      }
     
    } catch (e) {
      showAlertDialog(context, "Something wrong. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Nearest Recycle center',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
        
      ),
      body:CreateRecycleCenterBody(this),
    );
  }
  showConfirmDialog(BuildContext context, String text){
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, Routes.homeRoute);
        Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RecycleCenterScreen(),
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
      child: const Text("OK"),
      onPressed: () {
        //Navigator.pushNamed(context, routes.createRecycleCenterRoute);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
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
