import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_rclist.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart';
import 'package:my_green_app/ui/views/recyclecenter/view/view_map.dart';
import 'package:stacked/stacked.dart';
import '../recyclecenter/recyclecenter_viewmodel.dart';
import 'CreateRecycleCenter/create_recycle_center_screen.dart';


class RecycleCenterBody extends StatefulWidget {
  final RecycleCenterScreenfulState state;
  RecycleCenterBody({required this.state});

  @override
  State<RecycleCenterBody> createState() => _RecycleCenterBodyState();
}

class _RecycleCenterBodyState extends State<RecycleCenterBody> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecycleCenterViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children:  [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height:10),
              Container(
          width: 350,
          height: 50,
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold)),
              child: Text("Create"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CreateRecycleCenterScreen(),
            ));

              },
            ),
          ),
        ),
              SizedBox(height:10),
                  StreamBuilder<List<RecycleCenter>>(
                      stream: model.getRCList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }
                        if (snapshot.hasData) {
                          final recyclecenters = snapshot.data!;
                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: recyclecenters.map(buildRC).toList(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          );
                        } else {
                          return Center(child: Text('No data found'));
                        }
                  }),
            ],
          ),
        ),
        Positioned(
              top: 0,
              left:0,
              child: Container(
                child: widget.state.getViewContainer(context,model)
              ),
            ),
        ],
        ),
      ),
      viewModelBuilder: () => RecycleCenterViewmodel(),
    );
  }
}
