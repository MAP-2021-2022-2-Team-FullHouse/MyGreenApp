import 'package:flutter/material.dart';
import 'package:my_green_app/constants/routes_path.dart' as routes;
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_body.dart';
import 'package:my_green_app/ui/views/shop/manage_listing/managelisting_viewmodel.dart';


class ManageListingScreenful extends StatefulWidget {
  const ManageListingScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const ManageListingScreenful());

  @override
  State<ManageListingScreenful> createState() => ManageListingScreenfulState();
}

class ManageListingScreenfulState extends State<ManageListingScreenful> {
  ManageListingViewmodel viewmodel=ManageListingViewmodel();
  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      viewmodel.setUserEmail();
    });
          
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ManageListingBody(state:this));
  }

  Future<String?> getImgUrl(String imgUrl) async {
    return await viewmodel.getImgUrl(imgUrl);
  }

  void onDelete(ManageListingViewmodel viewmodel, String docid) async {
    await viewmodel.deleteListing(docid);
  }
}
