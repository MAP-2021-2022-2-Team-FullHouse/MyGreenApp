import '../../model/user.dart';
import 'counter_service.dart';
import '../../model/counter.dart';

// import '../../app/failures.dart';

var _mockDbCounter = Counter(id: 1, value: 100);

class CounterServiceMock extends CounterService {
  @override
  Future<Counter> readCounter() async {
    // Change the duration to a bigger value to test the progress indicator
    await Future.delayed(const Duration(milliseconds: 200));
    return _mockDbCounter;
  }

  @override
  // ignore: dead_code
  Future<Counter> writeCounter(Counter counter) async {
    // To simulate error occured during service call
    // throw Failures.cannotWrite;

    // Change the duration to a bigger value to test the progress indicator
    // ignore: dead_code
    await Future.delayed(const Duration(milliseconds: 200));

    _mockDbCounter = counter.copyWith();
    return _mockDbCounter;
  }
}
