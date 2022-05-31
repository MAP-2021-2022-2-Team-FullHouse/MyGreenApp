import 'dart:async';

import 'package:my_green_app/model/RecycleCenter.dart';

abstract class RecycleCenterService {
  Future deleteCenter(String documentId);
  Future getRCList();

  Stream<List<RecycleCenter>> readRC();
}
