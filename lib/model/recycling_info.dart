import 'package:cloud_firestore/cloud_firestore.dart';

class RecyclingInfo {
  late String infoId, title, content, image;
  late Timestamp createdDate;

  RecyclingInfo({
    this.infoId = '',
    this.title = '',
    this.content = '',
    this.image = '',
    Timestamp? creationDate,
  }) : createdDate = creationDate ?? Timestamp.now();

  static Future getRecyclingInfoList() async {
    // Get docs from collection reference
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('RecyclingInfo');
    List recyclingInfoList = [];
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    recyclingInfoList = querySnapshot.docs.map((doc) => doc.data()).toList();
    // Return List
    return recyclingInfoList;
  }

  static RecyclingInfo fromJson(Map<String, dynamic> json) => RecyclingInfo(
      infoId: json['infoId'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      creationDate: json['createdDate'] as Timestamp);
}
