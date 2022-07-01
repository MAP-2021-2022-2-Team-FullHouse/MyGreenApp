import 'dart:io';

import 'package:my_green_app/model/listing.dart';

abstract class ShopService {
  Stream<List<Listing>> readListingList(String email);
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
      required String useremail,
      File? file});
    Future editListing(
      {required String title,
      required String category,
      required String condition,
      required String price,
      required String description,
      required String method,
      required String image,
      required String useremail,
      required String docid,
      File? file});
    Future<Listing?> readListing(String docid);
    Future deleteListing(String docid);
}
