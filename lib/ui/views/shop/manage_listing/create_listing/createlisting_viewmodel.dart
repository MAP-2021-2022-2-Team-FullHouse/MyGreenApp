import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/shop/shop_service.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/create_listing/createlisting_screenstate.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class CreateListingViewmodel extends BaseViewModel {
  CreateListingViewmodel();
  late final _shopService = locator<ShopService>();
  static String userID = "";
  static late File? file;
  static late String fileName;
  final _navigationService = locator<NavigationService>();

  final _authService = locator<AuthenticationService>();

  void setUserID() {
    userID = _authService.getCurrentID();
  }

  static Future selectFile(CreateListingScreenfulState state) async {
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

  Future addListing({
    required String title,
    required String category,
    required String condition,
    required String price,
    required String description,
    required String method,
    required String image,
  }) async {
    dynamic result = await _shopService.addListing(
        title: title,
        category: category,
        condition: condition,
        image: image,
        price: price,
        description: description,
        method: method,
        file: file,
        userID: userID);
    if (result != null) {
    } else {
      return "Something went wrong.";
    }
  }
}
