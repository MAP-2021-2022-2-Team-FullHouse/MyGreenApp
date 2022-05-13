import 'package:flutter/material.dart';
import 'package:map_mvvm/map_mvvm.dart';
import '../../view/home/home_viewmodel.dart';
import '../ui_utils.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          View<HomeViewmodel>(
            builder: (_, viewmodel) => Text(
              // '${viewmodel.counter.value}',
              '${viewmodel.hasFailure ? ('Error occured: \n' + (viewmodel.failure?.toString())!) : viewmodel.counter.value}', // to simulate handling errors
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
