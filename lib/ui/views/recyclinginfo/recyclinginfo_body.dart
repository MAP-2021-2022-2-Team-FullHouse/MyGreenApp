import 'package:flutter/material.dart';
import 'package:my_green_app/model/recycling_info.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_list.dart';
import 'package:my_green_app/ui/views/recyclinginfo/recyclinginfo_screenstate.dart';
import 'package:stacked/stacked.dart';
import '../recyclinginfo/recyclinginfo_viewmodel.dart';
import 'create_recyclinginfo/create_recyclinginfo_screen.dart';

class RecyclingInfoBody extends StatefulWidget {
  final RecyclingInfoScreenfulState state;
  // ignore: use_key_in_widget_constructors
  const RecyclingInfoBody({required this.state});

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
                  const SizedBox(height: 10),
                  // ignore: sized_box_for_whitespace
                  Container(
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
                            builder: (context) => CreateRecyclingInfoScreen(),
                          ));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  StreamBuilder<List<RecyclingInfo>>(
                      stream: model.getRecyclingInfoList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                        if (snapshot.hasData) {
                          final recyclingInfos = snapshot.data!;
                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            // ignore: sort_child_properties_last
                            children:
                                recyclingInfos.map(buildRecyclingInfo).toList(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          );
                        } else {
                          return const Center(child: Text('No data found'));
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => RecyclingInfoViewmodel(),
    );
  }
}
