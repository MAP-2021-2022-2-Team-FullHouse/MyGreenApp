import 'package:flutter/material.dart';
import 'recyclecenter.dart';
import 'package:stacked/stacked.dart';
import 'CreateRecycleCenter/create_recycle_center_screen.dart';

class RecycleCenterBody extends StatefulWidget {
  final RecycleCenterScreenfulState state;
  const RecycleCenterBody({required this.state});

  @override
  State<RecycleCenterBody> createState() => _RecycleCenterBodyState();
}

class _RecycleCenterBodyState extends State<RecycleCenterBody> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecycleCenterViewmodel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        child: const Text("Create"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateRecycleCenterScreen(),
                          ));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<List<RecycleCenter>>(
                      stream: model.getRCList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                        if (snapshot.hasData) {
                          final recyclecenters = snapshot.data!;
                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: recyclecenters.map(buildRC).toList(),
                          );
                        } else {
                          return const Center(child: Text('No data found'));
                        }
                      }),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                  child: widget.state.getViewContainer(context, model)),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => RecycleCenterViewmodel(),
    );
  }
}
