import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/user.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/ui/views/profile/profile_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewmodel extends BaseViewModel {
  final _authService = locator<AuthenticationService>();
  late final _dialogService = locator<DialogService>();
  late final _navigationService = locator<NavigationService>();
  static late File? file;
  static late String fileName;
  static String currUserRole = "";
  late User _currUser = User();
  User get currUser => _currUser;

  ProfileViewmodel() {}

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return _authService.getUser();
  }

  Future<String?> getImgUrl(String imgUrl) async {
    var result = await _authService.getImage(imgUrl);
    return result;
  }

  static Future getUserRole() async {
    currUserRole = await AuthenticationServiceFirebase.getCurrentRole();
  }

  static String getRole() {
    getUserRole();
    return currUserRole;
  }

  Future updateUser(String name, String phone, String address) async {
    uploadFile(fileName);
    dynamic result = await _authService.updateUser(
        User(name: name, phone: phone, address: address, image: fileName));
    if (result == true) {
      /* setBusy(true);
      _dialogService.showDialog(
        title: 'Successfull',
        description: 'You have deleted the recycle center.',
        buttonTitle: 'OK',
        dialogPlatform: DialogPlatform.Material, // DialogPlatform.Material
      );
      setBusy(false); */
      _navigationService.navigateTo(profileRoute);
    } else {
      setBusy(true);
      _dialogService.showDialog(
        title: 'Failure',
        description: 'Something went wrong. Please try again.',
        buttonTitle: 'OK',
        dialogPlatform: DialogPlatform.Material, // DialogPlatform.Material
      );
      setBusy(false);
    }
  }

  static Future selectFile(ProfileScreenState profileState) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = await result.files.single.path!;
    file = await File(path);
    fileName = await path.substring(path.lastIndexOf('/') + 1);
    if (fileName != null) profileState.fileField.text = await fileName;
  }

  static Future uploadFile(String img) async {
    //print("sahd");
    if (file == null) {
      //print("noooooooooooooooooooooo");
      return;
    }

    final destination = '/$img';

    UploadTask? task =
        await AuthenticationServiceFirebase.uploadFile(destination, file!);
    print(fileName);

    if (task == null) return;

    final snapshot = await task.whenComplete(
        () {}); //final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    return img;
  }
}
