import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_green_app/ui/views/recyclecenter/UserView/rc_body.dart';

import '../CreateRecycleCenter/create_recycle_center_viewmodel.dart';
import 'rc_viewmodel.dart';

class RCScreenful extends StatefulWidget {
  const RCScreenful({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (_) => const RCScreenful());

  @override
  State<RCScreenful> createState() => RCScreenfulState();
}

class RCScreenfulState extends State<RCScreenful> {
  dynamic p;
  // @override
  // void initState() {
  //   getPosition();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // initState();

    return 
      FutureBuilder<Position?>(
        future: CreateRecycleCenter_ViewModel.getPosition(),
        builder: (context, snapshot) {
         
          if (snapshot.hasError) {
            return Center(
                child: Text(snapshot.error.toString()));
          }
           if (snapshot.hasData) {
             final r = snapshot.data!;
          return Scaffold(body: 
            RCBody(this, r),
          );
           }
           else {
            return const Center(child: Text('No data found'));
          }
        },
      );
    
  }

  Future<String?> getImgUrl(String imgUrl) async {
    RCViewmodel vm = RCViewmodel();

    return await vm.getImgUrl(imgUrl);
  }

  // getPosition() async {
  //   p = await CreateRecycleCenter_ViewModel.getPosition();
  // }
}
