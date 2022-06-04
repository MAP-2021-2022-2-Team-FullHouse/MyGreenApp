import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/constants/routes_path.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/services/navigation_service.dart';
import 'package:my_green_app/services/recycleCenter/recycleCenter_service.dart';
import 'package:my_green_app/services/user/user_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/recyclecenter/view/view_map.dart' as map;


class RecycleCenterViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  late final _dialogService = locator<DialogService>();
  late final _recycleCenterService = locator<RecycleCenterService>();
  late List<RecycleCenter> _rc = <RecycleCenter>[];
  List<RecycleCenter> get rc => _rc;
  static RecycleCenter recycleCenter= RecycleCenter();
  RecycleCenter get getRC=>recycleCenter;
  static bool viewAction=false;

  RecycleCenterViewmodel();

  Stream<List<RecycleCenter>> getRCList() {
    var results = _recycleCenterService.readRC();
    return results;
  }

  Future viewRC(context, String email)
  async {
    recycleCenter=await _recycleCenterService.getRC(email);
    viewAction=true;
    Navigator.of(context).pushNamed(routes.rcRoute);
  }

  void closeViewRC(context)
  {
    recycleCenter=RecycleCenter();
    viewAction=false;
    map.markers.clear();
    Navigator.of(context).pushNamed(routes.rcRoute);
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

      if (result == true) {
        result = null;
        _dialogService.showDialog(
          title: 'Successfull',
          description: 'You have deleted the recycle center.',
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
