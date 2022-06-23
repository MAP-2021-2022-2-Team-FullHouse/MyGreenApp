
import 'package:my_green_app/services/reward/reward_firebaseservice.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/locator.dart';
import '../../../../model/Reward.dart';
import '../../../../services/reward/reward_service.dart';


class UserRewardViewmodel extends BaseViewModel {
  /* StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null; */
  late final _dialogService = locator<DialogService>();
  RewardService rewardService=RewardFirebaseService();
  late final List<Reward> _rewards = <Reward>[];
  List<Reward> get getRewards=> _rewards;
  Reward reward= Reward();
  Reward get getReward=>reward;
  static bool viewAction=false;
  bool get isViewAction=>viewAction;

  UserRewardViewmodel();

  Stream<List<Reward>> getUserRewardList() {
    var results = rewardService.readUserRewards();
    return results;
  }

  Future isPointSufficient(String rewardId)async{
    return await rewardService.isPointSufficient(rewardId);
    
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
