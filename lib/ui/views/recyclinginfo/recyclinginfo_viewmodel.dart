import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;

class RecyclingInfoViewmodel extends BaseViewModel {
  late final _dialogService = locator<DialogService>();
  late final _recyclingInfoService = locator<RecyclingInfoService>();
  late List<RecyclingInfo> _rc = <RecyclingInfo>[];
  List<RecyclingInfo> get rc => _rc;
  static RecyclingInfo recyclingInfo = RecyclingInfo();
  RecyclingInfo get getRC => recyclingInfo;
  static bool viewAction = false;
  bool get isViewAction => viewAction;

  RecyclingInfoViewmodel();

  Stream<List<RecyclingInfo>> getRecyclingInfoList() {
    var results = _recyclingInfoService.readRecyclingInfo();
    return results;
  }

  /*Future viewRC( String email)
  async {
    recycleCenter=await _recycleCenterService.getRC(email);
    viewAction=true;
  }*/

  Future<String?> getImgUrl(String imgUrl) async {
    var result = await _recyclingInfoService.getRecyclingInfoImage(imgUrl);
    return result;
  }

  Future deleteRecyclingInfo(String id) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the recycling info?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);
      dynamic result = await _recyclingInfoService.deleteRecyclingInfo(id);

      if (result == true) {
        result = null;
        _dialogService.showDialog(
          title: 'Successfull',
          description: 'You have deleted the recycling info',
          buttonTitle: 'OK',
          dialogPlatform: DialogPlatform.Material, // DialogPlatform.Material
        );
        setBusy(false);
        //_navigationService.navigateTo(homeRoute);
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
