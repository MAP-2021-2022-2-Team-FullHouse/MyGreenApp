import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_green_app/services/dialog_service.dart' as dg;
import 'package:path/path.dart' as Path;
import 'package:my_green_app/ui/views/appointment/CreateAppointment/CreateAppointment_ViewModel.dart';
import 'package:stacked_services/stacked_services.dart';

class AddImage extends StatefulWidget {
  @override
  AddImageState createState() => AddImageState();
}

class AddImageState extends State<AddImage> {
  bool uploading = false;
  double val = 0;
  //CreateAppointment_ViewModel viewmodel = CreateAppointment_ViewModel();

  List<File> image = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Image'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  //uploadFile().whenComplete(() => Navigator.of(context).pop());
                  if (image != null) {
                    setState(() {
                      uploading = true;
                    });
                    CreateAppointment_ViewModel.imgFiles = image;
                    print(image);
                    Navigator.of(context).pop();
                  } else {
                    DialogService().showDialog(
                      title: 'Reminder',
                      description: 'Please upload at least 1 image.',
                      buttonTitle: 'OK',
                      dialogPlatform:
                          DialogPlatform.Material, // DialogPlatform.Material
                    );
                  }
                },
                child: const Text(
                  'Upload',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                  itemCount: image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                            child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () =>
                                    !uploading ? chooseImage() : null),
                          )
                        : Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(image[index - 1]),
                                    fit: BoxFit.cover)),
                          );
                  }),
            ),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: const Text(
                          'uploading...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                : Container(),
          ],
        ));
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image.add(File(pickedFile.path));
      } else {}
    });
    if (pickedFile?.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  @override
  void initState() {
    super.initState();
    //imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}
