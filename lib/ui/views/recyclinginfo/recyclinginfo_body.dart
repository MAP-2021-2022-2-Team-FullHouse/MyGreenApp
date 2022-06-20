import 'package:flutter/material.dart';
import 'package:my_green_app/model/recycling_info.dart';
//import 'package:my_green_app/ui/views/recyclecenter/RecyclingInfo_rclist.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screenstate.dart';
import 'package:stacked/stacked.dart';
import '../recyclinginfo/recyclinginfo_viewmodel.dart';
import 'create_recyclinginfo/create_recyclinginfo_screen.dart';

class RecyclingInfoBody extends StatefulWidget {
  final RecyclingInfoScreenfulState state;
  RecyclingInfoBody({required this.state});

  @override
  State<RecyclingInfoBody> createState() => _RecyclingInfoBodyState();
}

class _RecyclingInfoBodyState extends State<RecyclingInfoBody> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecyclingInfoViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: 350,
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        child: Text("Create"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateRecyclingInfoScreen(),
                          ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          10), /*
                  StreamBuilder<List<RecyclingInfo>>(
                      stream: model.getRCList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }
                        if (snapshot.hasData) {
                          final RecyclingInfos = snapshot.data!;
                          return ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: RecyclingInfos.map(buildRC).toList(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          );
                        } else {
                          return Center(child: Text('No data found'));
                        }
                      }),*/
                ],
              ),
            ), /*
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                  child: widget.state.getViewContainer(context, model)),
            ),*/
          ],
        ),
      ),
      viewModelBuilder: () => RecyclingInfoViewmodel(),
    );
  }
}
