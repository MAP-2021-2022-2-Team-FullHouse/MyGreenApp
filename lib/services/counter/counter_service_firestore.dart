import 'package:cloud_firestore/cloud_firestore.dart';
import 'counter_service.dart';
import '../../model/counter.dart';
import 'package:map_mvvm/failure.dart';
// import '../../app/failures.dart';

class CounterServiceFirestore extends CounterService {
  static const _userId = 'user1001';
  @override
  Future<Counter> readCounter() async {
    try {
      final doc =
          await FirebaseFirestore.instance.doc('counters/$_userId').get();
      final counter = Counter.fromJson(doc.data()!);
      return counter;
    } on FirebaseException catch (e) {
      // throw Failures.cannotRead;
      throw Failure(100,
          message: e.toString(),
          location:
              'CounterServiceFireStore.readCounter() on FirebaseException');
    } catch (e) {
      throw Failure(101,
          message: e.toString(),
          location: 'CounterServiceFireStore.readCounter() on other exception');
    }
  }

  @override
  Future<Counter> writeCounter(Counter counter) async {
    try {
      await FirebaseFirestore.instance
          .doc('counters/$_userId')
          .set(counter.toJson());
      return counter.copyWith();
    } on FirebaseException catch (e) {
      // throw Failures.cannotWrite;
      throw Failure(200,
          message: e.toString(),
          location:
              'CounterServiceFireStore.writeCounter() on FirebaseException');
    } catch (e) {
      throw Failure(201,
          message: e.toString(),
          location:
              'CounterServiceFireStore.writeCounter() on other exceptions');
    }
  }

  @override
  Stream? get stream =>
      FirebaseFirestore.instance.doc('counters/$_userId').snapshots();

  @override
  Future<Counter?> transformData(data) async {
    try {
      final doc = await data.data();
      final counter = Counter.fromJson(doc);
      return counter;
    } on FirebaseException catch (e) {
      throw Failure(300,
          message: e.toString(),
          location:
              'CounterServiceFireStore.transformData() on FirebaseException');
    } catch (e) {
      throw Failure(301,
          message: e.toString(),
          location:
              'CounterServiceFireStore.transformData() on other exception');
    }
  }
}
