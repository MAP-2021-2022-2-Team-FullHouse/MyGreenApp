
import 'package:my_green_app/services/authentication/authentication_service_firebase.dart';
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/locator.dart';
import '../../../../model/Reward.dart';
import '../../../../model/RewardUnit.dart';
import '../../../../services/reward/reward_service.dart';


class AdminRewardViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  late final _dialogService = locator<DialogService>();
  RewardService rewardService=RewardFirebaseService();
  AuthenticationService authService=AuthenticationServiceFirebase();
  late final List<Reward> _rewards = <Reward>[];
  List<Reward> get getRewards=> _rewards;
  Reward reward= Reward();
  Reward get getReward=>reward;
  static bool viewAction=false;
  bool get isViewAction=>viewAction;

  AdminRewardViewmodel();

  Stream<List<Reward>> getRewardList() {
    var results = rewardService.readRewards();
    return results;
  }
  Stream<List<RewardUnit>>getRewardUnitListPersonalized(){
    var results=rewardService. readRewardUnitsPersonalized();
    return results;
  }
  Stream<List<RewardUnit>> getRewardUnitList() {
    var results = rewardService.readRewardUnits();
    return results;
  }
   Future<Reward> readReward(String id)async {
    var rc = await rewardService.getReward(id);
    return rc;
  }

  
  Future<String> readUser(String id)async{
    var result =await authService.readUser(id);
   
    return result.name;
  }


  Future viewReward( String docID)
  async {
    reward=await rewardService.getReward(docID);
    viewAction=true;
   
  }


  Future deleteReward(String docID) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the reward?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse!.confirmed) {
      setBusy(true);
      dynamic result = await rewardService.deleteReward(docID);

      if (result == true) {
        result = null;
        _dialogService.showDialog(
          title: 'Successfull',
          description: 'You have deleted the reward.',
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
