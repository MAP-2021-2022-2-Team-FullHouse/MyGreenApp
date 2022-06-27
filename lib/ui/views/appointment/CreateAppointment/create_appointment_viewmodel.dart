import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/ui/views/appointment/CreateAppointment/create_appointment_upload.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'dart:io';

import '../../../../services/appointment/appointment_service.dart';
import '../../../../services/appointment/appointment_service_firebase.dart';

class CreateAppointment_ViewModel extends BaseViewModel {
  final _AppointmentService = locator<AppointmentService>();
  late final _authenticationService = locator<AuthenticationService>();
  static String retrievedRCEmail = '';
  String get getEmail => retrievedRCEmail;
  static late String lat;
  static late String currUserEmail;
  String get getUserEmail => currUserEmail;
  static late String currUserID;
  String get getUserID => currUserID;
  static late String lon;
  static late File? file;
  static late String fileName;
  static late List<File> imgFiles;
  static List<String> imagesURL = [];
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  CreateAppointment_ViewModel() {
    _errorMessage = '';
  }

  static List<File> getUploadedImages(AddImageState imagesState) {
    return imagesState.image;
  }

  Future addAppointment(
      {required String name,
      required String category,
      required String quantity,
      required String remark,
      required String dateTimeInput,
      required String deliveryMethod,
      required AddImageState state}) async {
    //String uid = _authenticationService.getUID();
    //currUserID = uid;
    var uEmail = await _authenticationService.getCurrentUserEmail();
    // currUserEmail = uEmail;
    dynamic result = await _AppointmentService.addAppointment(
        name: name,
        category: category,
        dateTime: dateTimeInput,
        deliveryMethod: deliveryMethod,
        userEmail: uEmail.toString(),
        rcEmail: retrievedRCEmail,
        remark: remark,
        quantity: quantity,
        imageURLs: imgFiles);

    if (result != null) {
      return result;
    } else {
      return "Something went wrong.";
    }
  }

  /* static Future uploadFile(AddImageState state) async {
    int i = 1;
    var image = getUploadedImages(state);
    var ref;

    for (var img in image) {
      ref = AppointmentServiceFirebase.transferReference(img, currUserEmail);
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          //imgRef.add({'url': value});
          imagesURL.add(value);
          i++;
        });
      });
    }
    return imagesURL;
  } */
}
