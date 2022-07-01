import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service.dart';
import 'package:my_green_app/services/user/user_repository.dart';
import 'package:my_green_app/ui/views/recyclecenter/view/view_map.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RecycleCenterViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  late final _dialogService = locator<DialogService>();
  late final _recycleCenterService = locator<RecycleCenterService>();
  late List<RecycleCenter> _rc = <RecycleCenter>[];
  List<RecycleCenter> get rc => _rc;
  static RecycleCenter recycleCenter = RecycleCenter();
  RecycleCenter get getRC => recycleCenter;
  static bool viewAction = false;
  bool get isViewAction => viewAction;

  RecycleCenterViewmodel();

  Stream<List<RecycleCenter>> getRCList() {
    var results = _recycleCenterService.readRC();
    return results;
  }

  Future viewRC(String email) async {
    recycleCenter = await _recycleCenterService.getRC(email);
    viewAction = true;
  }

  Future<String?> getImgUrl(String imgUrl) async {
    var result = await _recycleCenterService.getImage(imgUrl);
    return result;
  }

  void closeViewRC() {
    recycleCenter = RecycleCenter();
    viewAction = false;
    ViewMap.markers.clear();
  }

  Future deleteCenter(String email) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the recycle center?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);
      dynamic result = await _recycleCenterService.deleteCenter(email);

      if (result == "ok") {
        result = null;
        _dialogService.showDialog(
          title: 'Success',
          description: 'You have deleted the recycle center.',
          buttonTitle: 'OK',
          dialogPlatform: DialogPlatform.Material, // DialogPlatform.Material
        );
        setBusy(false);
      } else {
        result = "Error";
        _dialogService.showDialog(
          title: 'Failure',
          description: 'Something went wrong. Please try again.',
          buttonTitle: 'OK',
          dialogPlatform: DialogPlatform.Material, // DialogPlatform.Material
        );
        setBusy(false);
      }
    }
  }
}
