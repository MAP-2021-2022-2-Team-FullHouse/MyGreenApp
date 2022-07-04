import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/ui/views/recyclinginfo/edit_recyclinginfo/edit_recyclinginfo_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../../services/recycling_info/recycling_info_service.dart';

// ignore: camel_case_types
class EditRecyclingInfo_ViewModel extends BaseViewModel {
  // ignore: non_constant_identifier_names
  final _RecyclingInfoService = locator<RecyclingInfoService>();
  static late File? file;
  static late String fileName;
  late String _errorMessage;
  String get errorMessage => _errorMessage;
  EditRecyclingInfo_ViewModel() {
    _errorMessage = '';
  }

  static Future selectFile(EditRecyclingInfoScreenState state) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    // ignore: await_only_futures
    final path = await result.files.single.path!;
    // ignore: await_only_futures
    file = await File(path);
    // ignore: await_only_futures
    fileName = await path.substring(path.lastIndexOf('/') + 1);
    // ignore: unnecessary_null_comparison
    if (fileName != null) {
      // ignore: await_only_futures
      state.fileField.text = await fileName;
    }
  }

  Future<RecyclingInfo?> readRecyclingInfo(String infoId) {
    var recyclingInfo = _RecyclingInfoService.readRecyclingInfo(infoId);
    return recyclingInfo;
  }

  Future editRecyclingInfo({
    required String infoId,
    required String title,
    required String content,
    required String image,
  }) async {
    dynamic result = await _RecyclingInfoService.editRecyclingInfo(
      infoId: infoId,
      title: title,
      content: content,
      image: image,
      file: file,
    );
    if (result == "ok") {
      return "ok";
    } else {
      return "Something went wrong.";
    }
  }
}
