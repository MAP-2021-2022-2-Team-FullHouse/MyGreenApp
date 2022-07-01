import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/services/shop/shop_service.dart';
import 'package:stacked/stacked.dart';

class ShopViewmodel extends BaseViewModel {
  ShopViewmodel();
  late final _shopService = locator<ShopService>();
  
  Stream<List<Listing>> getListingList() {
    var results = _shopService.readAllListingList();
    return results;
  }

  Future<String?> getImgUrl(String imgUrl) async {
    var result=await _shopService.getImage(imgUrl);
    return result;
  }
}
