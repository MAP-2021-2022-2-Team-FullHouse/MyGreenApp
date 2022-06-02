import 'package:flutter/material.dart';
import 'package:my_green_app/model/RecycleCenter.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_rclist.dart';
import 'package:my_green_app/ui/views/recyclecenter/recyclecenter_screenstate.dart';
import 'package:stacked/stacked.dart';
import '../recyclecenter/recyclecenter_viewmodel.dart';

class RecycleCenterBody extends StatelessWidget {
  final RecycleCenterScreenfulState _state;
  const RecycleCenterBody(this._state);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecycleCenterViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                  })
            ],
          ),
        ),
      ),
      viewModelBuilder: () => RecycleCenterViewmodel(),
    );
  }
}
