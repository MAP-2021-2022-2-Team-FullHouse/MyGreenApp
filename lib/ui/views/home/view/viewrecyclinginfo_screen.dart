import 'package:flutter/material.dart';
import 'package:my_green_app/ui/views/home/view/viewrecyclinginfo_body.dart';
import 'viewrecyclinginfo_viewmodel.dart';

class ViewRecyclingInfoScreen extends StatefulWidget {
  final String infoId;
  const ViewRecyclingInfoScreen({Key? key, required this.infoId})
      : super(key: key);
  String get rlinfoId => infoId;
  @override
  ViewRecyclingInfoScreenState createState() => ViewRecyclingInfoScreenState();
}

class ViewRecyclingInfoScreenState extends State<ViewRecyclingInfoScreen> {
  late String rlId;
  @override
  Widget build(BuildContext context) {
    rlId = widget.infoId;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was Editd by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'Recycle Info',
          style: TextStyle(color: Colors.black.withOpacity(1.0)),
        ),
      ),
      body: ViewRecyclingInfoBody(this),
    );
  }

  Future<String?> getImgUrl(String imgUrl) async {
    ViewRecyclingInfo_ViewModel viewmodel = ViewRecyclingInfo_ViewModel();
    return await viewmodel.getImgUrl(imgUrl);
  }
}
