import 'dart:async';

import 'package:my_green_app/model/RecycleCenter.dart';

abstract class RecycleCenterService {
  Future deleteCenter(String docemail);
  Future getRCList();
  Stream<List<RecycleCenter>> readRC();
}
