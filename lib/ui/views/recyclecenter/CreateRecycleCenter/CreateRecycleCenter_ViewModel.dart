
import 'package:my_green_app/services/recycleCenter/GPSService.dart';
import 'package:my_green_app/ui/views/recyclecenter/CreateRecycleCenter/CreateRecycleCenter_Screen.dart';
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

class CreateRecycleCenter_ViewModel extends BaseViewModel{
   final _recycleCenterService = locator<RecycleCenterService>();
  //final _navigationService = locator<NavigationService>();
  // final _gpsService = locator<GPSService>();
   static late String lat;
   static late String lon;
   static late File?  file;
   static late String fileName;
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  CreateRecycleCenter_ViewModel(){
    _errorMessage='';
  }
 static Future<Position> getPosition()async{
   
   Position p=await GPSService.obtainLatLon();
   return p;
 }
static Future selectFile(CreateRecycleCenterScreenState state) async {
  
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = await result.files.single.path!;
    file=await File(path);
    fileName=await path.substring(path.lastIndexOf('/')+1); 
    if(fileName!=null)
    state.fileField.text=await fileName;
  }
  static Future uploadFile(String img) async {
    print("sahd");
    if (file == null) {
      print("noooooooooooooooooooooo");
      return;}
    
    //final fileName = basename(file!.path);
    
    final destination = 'files/$img';

    UploadTask? task = await RecycleCenterServiceFirebase.uploadFile(destination, file!);
   print(fileName);

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});//final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }
  
 
  
  Future addRecycleCenter(
      { required String name,
      required String address,
      required String phone,
      required String image,
      required String email,
      required double lat,
      required double lon,
      required String password,
      }) async {

    dynamic result = await _recycleCenterService.addRecycleCenter(
      name: name,
       address: address,
        phone: phone,
        image:image,
        email: email,
        lat:lat,
        lon:lon,
        password: password,
       );
      uploadFile( image); 
    if (result != null) {
      if (result == 'email-already-in-use') {
        return "Email is registered.";
      } else if (result == "weak-password") {
        return "Weak password";
      } else if (result == 'invalid-email') {
        return "Invalid email address.";
      }else if (result == 'name duplicated') {
        return "Name duplicated";
      }else if (result == 'image duplicated') {
        return "Image duplicated";
      }else if (result == 'phone duplicated') {
        return "Phone duplicated";
      }else {
        return "ok";
      }
      //  else {
        
      //   _navigationService.navigateTo(routes.createRecycleCenterRoute);
      // }
    } else {
      return "Something went wrong.";
      
    }
  }

//   Future<bool> isRecycleCenterNameExist(String name)async{
//  return RecycleCenterServiceFirebase.isRecycleCenterNameExist(name);

//   }


 

}
