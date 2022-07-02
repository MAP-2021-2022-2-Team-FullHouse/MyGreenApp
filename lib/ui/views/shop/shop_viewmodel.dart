import 'package:my_green_app/app/locator.dart';
import 'package:my_green_app/model/listing.dart';
import 'package:my_green_app/services/authentication/authentication_service.dart';
import 'package:my_green_app/services/shop/shop_service.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShopViewmodel extends BaseViewModel {
  ShopViewmodel();
  late final _shopService = locator<ShopService>();
  late final _authService = locator<AuthenticationService>();
  
  Stream<List<Listing>> getListingList() {
    var results = _shopService.readAllListingList();
    return results;
  }

  Future<String?> getImgUrl(String imgUrl) async {
    var result=await _shopService.getImage(imgUrl);
    return result;
  }

  Future contactSeller(Listing model) async
  {
    var sellerPhoneNo=await _authService.getPhoneNo(model.sellerID);
    String text= "Hi ${model.seller}! I am interested to the *${model.title}* you listed in MyGreenApp!";

    var whatsappURl = "whatsapp://send?phone=+6$sellerPhoneNo&text=$text";    
    // if(await canLaunchUrlString(whatsappURl))
    // {
      await launchUrlString(whatsappURl);
    // }
    // else
    // {
    //   print("error");
    // }
    
  }
}
