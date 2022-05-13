import 'dart:async';

import 'package:map_mvvm/viewmodel.dart';
import '../../app/app.dart';

import '../../../app/service_locator.dart';
import '../../model/counter.dart';
import '../../services/counter/counter_service.dart';

class HomeViewmodel extends Viewmodel {
  CounterService get _service => locator<CounterService>();
  Counter _counter = Counter();
  StreamSubscription? _streamListener;
  bool get isListeningToStream => _streamListener != null;

  @override
  void init() async {
    super.init();
    notifyListenersOnFailure = true;

    await update(() async => _counter = await _service.readCounter());
    _streamListener = _service.listen(
      onData: (data) async =>
          await update(() async => _counter = (data as Counter).copyWith()),
      onError: (e) => catchError(e),
    );
  }

  Counter get counter => _counter;

  Future<void> incrementCounter() async =>
      await update(() async => _counter = await _service.incrementCounter());

  @override
  void dispose() {
    _streamListener?.cancel();
    _streamListener = null;
    super.dispose();
  }
}
