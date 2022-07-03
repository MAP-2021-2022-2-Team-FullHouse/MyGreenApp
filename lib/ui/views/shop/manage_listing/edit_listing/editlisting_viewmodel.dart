import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/shop/shop_service.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/edit_listing/editlisting_screenstate.dart';
import 'package:stacked/stacked.dart';

class EditListingViewmodel extends BaseViewModel {
  EditListingViewmodel();
  late final _shopService = locator<ShopService>();
  late final _authService = locator<AuthenticationService>();
  static String userID = "";
  static late File? file;
  static late String fileName;
  static String docid = "";
  static get id => docid;

  void setUserID() {
    userID = _authService.getCurrentID();
  }

  static Future selectFile(EditListingScreenfulState state) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    // ignore: await_only_futures
    final path = await result.files.single.path!;
    // ignore: await_only_futures
    file = await File(path);
    // ignore: await_only_futures
    fileName = await path.substring(path.lastIndexOf('/') + 1);
    // ignore: unnecessary_null_comparison
    if (fileName != null)
    // ignore: await_only_futures
    {
      state.fileField.text = await fileName;
    }
  }

  // static Future uploadFile(String img) async {
  //   if (file == null) {
  //     return;
  //   }
  //   final destination = '/listing/$img';

  //   UploadTask? task =
  //       await AuthenticationServiceFirebase.uploadFile(destination, file!);

  //   if (task == null) return;

  //   final snapshot = await task.whenComplete(
  //       () {}); //final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();

  //   print('Download-Link: $urlDownload');
  //   return img;
  // }

  Future editListing({
    required String title,
    required String category,
    required String condition,
    required String price,
    required String description,
    required String method,
    required String image,
  }) async {
    dynamic result = await _shopService.editListing(
        title: title,
        category: category,
        condition: condition,
        image: image,
        price: price,
        description: description,
        method: method,
        file: file,
        userID: userID,
        docid: docid);
    if (result != null) {
    } else {
      return "Something went wrong.";
    }
  }

  Future<Listing?> readListing(String docid) {
    var listing = _shopService.readListing(docid);

    return listing;
  }
}
