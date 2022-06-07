import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/recycleCenter/GPSService.dart';
import 'package:my_green_app/ui/views/recyclecenter/EditRecycleCenter/EditRecycleCenter_Screen.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/services/navigation_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

import '../../../../services/recycleCenter/recycleCenter_service.dart';
import '../../../../services/recycleCenter/recycleCenter_service_firebase.dart';

class EditRecycleCenter_ViewModel extends BaseViewModel {
  final _recycleCenterService = locator<RecycleCenterService>();

  static late String lat;
  static late String lon;
  static late File? file;
  static late String fileName;
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  EditRecycleCenter_ViewModel() {
    _errorMessage = '';
  }

  Future<RecycleCenter?> readCenter(String docEmail) {
    var rc = _recycleCenterService.readCenter(docEmail);
    return rc;
  }

  static Future<Position> getPosition() async {
    Position p = await GPSService.obtainLatLon();
    return p;
  }

  static Future selectFile(EditRecycleCenterScreenState state) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = await result.files.single.path!;
    file = await File(path);
    fileName = await path.substring(path.lastIndexOf('/') + 1);
    if (fileName != null) state.fileField.text = await fileName;
  }

  static Future uploadFile(String img) async {
    if (file == null) {
      return;
    }
    final destination = 'files/$img';

    UploadTask? task =
        await RecycleCenterServiceFirebase.uploadFile(destination, file!);
    print(fileName);

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Future editRecycleCenter({
    required String oriemail,
    required String name,
    required String address,
    required String phone,
    required String image,
    required String email,
    required double lat,
    required double lon,
    required String password,
  }) async {
    dynamic result = await _recycleCenterService.editRecycleCenter(
      oriemail: oriemail,
      name: name,
      address: address,
      phone: phone,
      image: image,
      email: email,
      lat: lat,
      lon: lon,
      password: password,
    );
    uploadFile(image);
    if (result != null) {
      if (result == 'email registered by others"') {
        return "Email is registered.";
      } else if (result == "weak-password") {
        return "Weak password";
      } else if (result == 'invalid-email') {
        return "Invalid email address.";
      } else if (result == 'name duplicated') {
        return "Name duplicated";
      } else if (result == 'phone duplicated') {
        return "Phone duplicated";
      } else {
        return "ok";
      }
    } else {
      return "Something went wrong.";
    }
  }
}
