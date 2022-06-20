import 'dart:async';
import 'package:my_green_app/model/recycling_info.dart';
import 'dart:io';

abstract class RecyclingInfoService {
  Future addRecyclingInfo(
      {required String title,
      required String content,
      required String image,
      //required String createdDate,
      File? file});
  Future deleteRecyclingInfo(String infoId);
  //Future<String> getRecyclingInfoImage(String pathname);
  /*Future editRecyclingInfo(
      {required String id,
      required String title,
      required String content,
      required String image,
      required String creationDate});
  Future deleteCenter(String infoId);
  Future getRecyclingInfoList();
  Stream<List<RecyclingInfo>> readRecyclingInfo();
  Future<RecyclingInfo?> getRecyclingInfo(String infoId);
  Future getRC(String docemail);
  */
}
