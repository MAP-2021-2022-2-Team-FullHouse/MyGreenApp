import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/shop/shop_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class ManageListingViewmodel extends BaseViewModel {
  ManageListingViewmodel();
  late final _shopService = locator<ShopService>();
  static String userID="";
  late final _dialogService = locator<DialogService>();

  
  void setUserID(){
    userID= AuthenticationServiceFirebase.getCurrentID();
  }

  Stream<List<Listing>> getListingList() {
    var results = _shopService.readListingList(userID);
    return results;
  }

  Future<String?> getImgUrl(String imgUrl) async {
    var result=await _shopService.getImage(imgUrl);
    return result;
  }

  Future deleteListing(String docid) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the recycle center?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);
      dynamic result = await _shopService.deleteListing(docid);

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
