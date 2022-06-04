import 'dart:async';

import 'package:my_green_app/model/RecycleCenter.dart';

abstract class RecycleCenterService {
  Future deleteCenter(String docemail);
  Future getRCList();
  Stream<List<RecycleCenter>> readRC();
  Future addRecycleCenter(
      {required String name,
      required String address,
      required String phone,
      required String image,
      required String email,
      required double lat,
      required double lon,
      required String password

      });
  
  Future<bool> isPhoneExist(String name);
  Future<bool> isImageExist(String name);
  Future<bool> isRecycleCenterNameExist(String name);
  Future getRC(String docemail);
}
