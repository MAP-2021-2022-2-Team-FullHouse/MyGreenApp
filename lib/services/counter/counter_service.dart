import 'package:map_mvvm/map_mvvm.dart';

import '../../model/counter.dart';
import '../../model/user.dart';

abstract class CounterService with ServiceStream {
  Future<Counter> readCounter();
  Future<Counter> writeCounter(Counter counter);
  //Future<void> readName();
  Future<Counter> incrementCounter() async {
    Counter _counter = await readCounter();
    _counter = _counter.copyWith(value: _counter.value + 1);
    _counter = await writeCounter(_counter);
    return _counter;
  }
}
