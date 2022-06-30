import 'package:cloud_firestore/cloud_firestore.dart';

class RecycleCenter {
  late String name, address, phone, image, email;
  late double lat, lon;
  late String documentId;
  late String password;

  RecycleCenter(
      {this.name = '',
      this.address = '',
      this.phone = '',
      this.image = '',
      this.email = '',
      this.lat = -999,
      this.lon = -999,
      this.documentId = '',
      this.password=''});


  static Future getCenterList() async {
    // Get docs from collection reference
    // ignore: no_leading_underscores_for_local_identifiers
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('RecycleCenter');
    List centerList = [];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return centerList;
  }

  static RecycleCenter fromJson(Map<String, dynamic> json) => RecycleCenter(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      image: json['image'],
      email: json['email'],
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      password: json['password']);

      Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'phone': phone,
        'image': image,
        'email': email,
        'lat':lat,
        'lon':lon,
        'password':password, 
      };
}


