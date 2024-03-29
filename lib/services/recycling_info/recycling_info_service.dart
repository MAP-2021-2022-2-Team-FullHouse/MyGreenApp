import 'dart:async';
import '../../model/recycling_info.dart';
import 'dart:io';

abstract class RecyclingInfoService {
  Future addRecyclingInfo(
      {required String title,
      required String content,
      required String image,
      File? file});
  Future editRecyclingInfo(
      {required String infoId,
      required String title,
      required String content,
      required String image,
      File? file});
  Future deleteRecyclingInfo(String infoId);
  Stream<List<RecyclingInfo>> readRecyclingInfoList();
  Future<String> getRecyclingInfoImage(String pathname);
  Future<RecyclingInfo?> readRecyclingInfo(String infoId);
}
