import 'package:my_green_app/model/recycling_info.dart';
//import 'package:my_green_app/ui/views/recyclinginfo/view/viewrecyclinginfo_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/services/recycling_info/recycling_info_service.dart';
import '../../../../app/locator.dart';

// ignore: camel_case_types
class ViewRecyclingInfo_ViewModel extends BaseViewModel {
  final _recyclingInfoService = locator<RecyclingInfoService>();

  ViewRecyclingInfo_ViewModel();

  Future<RecyclingInfo?> readRecyclingInfo(String infoId) {
    var recyclingInfo = _recyclingInfoService.readRecyclingInfo(infoId);
    return recyclingInfo;
  }

  Future<String?> getImgUrl(String imgUrl) async {
    var result = await _recyclingInfoService.getRecyclingInfoImage(imgUrl);
    return result;
  }
}
