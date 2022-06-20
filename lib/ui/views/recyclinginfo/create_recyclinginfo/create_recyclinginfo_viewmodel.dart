import 'package:my_green_app/ui/views/recyclinginfo/create_recyclinginfo/create_recyclinginfo_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../../../../services/recycling_info/recycling_info_service.dart';
import '../../../../services/recycling_info/recycling_info_service_firebase.dart';

class CreateRecyclingInfo_ViewModel extends BaseViewModel {
  final _RecyclingInfoService = locator<RecyclingInfoService>();
  static late File? file;
  static late String fileName;
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  CreateRecyclingInfo_ViewModel() {
    _errorMessage = '';
  }

  static Future selectFile(CreateRecyclingInfoScreenState state) async {
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
      state.fileField.text = fileName;
    }
    //return file;
  }

  /*static Future uploadFile(String img) async {
    if (file == null) {
      return;
    }
    final destination = 'recyclingInfo/$img';
    UploadTask? task =
        await RecyclingInfoServiceFirebase.uploadFile(destination, file!);
    if (task == null) return;
  }*/

  Future addRecyclingInfo({
    required String title,
    required String content,
    required String image,
  }) async {
    dynamic result = await _RecyclingInfoService.addRecyclingInfo(
      title: title,
      content: content,
      image: image,
      file: file,
    );
    if (result != null) {
      return "ok";
    } else {
      return "Something went wrong.";
    }
  }
}
