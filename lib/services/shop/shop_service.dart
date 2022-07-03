import 'dart:io';

import 'package:my_green_app/model/listing.dart';

abstract class ShopService {
  Stream<List<Listing>> readListingList(String userID);
  Stream<List<Listing>> readAllListingList();
  Future<String> getImage(String pathname);
  Future addListing(
      {required String title,
      required String category,
      required String condition,
      required String price,
      required String description,
      required String method,
      required String image,
      required String userID,
      File? file});
    Future editListing(
      {required String title,
      required String category,
      required String condition,
      required String price,
      required String description,
      required String method,
      required String image,
      required String userID,
      required String docid,
      File? file});
    Future<Listing?> readListing(String docid);
    Future deleteListing(String docid);
    Future contactSeller(String phoneNo, Listing model);
}
