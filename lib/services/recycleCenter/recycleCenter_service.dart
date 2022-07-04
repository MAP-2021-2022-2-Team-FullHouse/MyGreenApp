import 'dart:async';
import 'dart:io';

import 'package:my_green_app/model/RecycleCenter.dart';

abstract class RecycleCenterService {
  Future deleteCenter(String docemail);
  Future getRCList();
  Stream<List<RecycleCenter>> readRC();
  Future<RecycleCenter?> readCenter(String docemail);
  Future addRecycleCenter(
      {required RecycleCenter rc,
   
      File? file});
  Future editRecycleCenter(
      {required String oriemail,
      required String name,
      required String address,
      required String phone,
      required String image,
      required String email,
      required double lat,
      required double lon,
      required String password});
  Future<bool> isPhoneExist(String name);
  Future<bool> isImageExist(String name);
  Future<bool> isRecycleCenterNameExist(String name);
  Future<bool> isRecycleCenterNameUsedByOthers(String name, String email);
  Future<bool> isPhoneRegisteredByOthers(String phone, String email);
  Future<bool> isEmailRegisteredByOthers(String oriemail, String newemail);
  Future getRC(String docemail);
  Future<String> getImage(String pathname);
  Future queryData(String queryString);
}
