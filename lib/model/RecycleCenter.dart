import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecycleCenter{
    late String name,address, phone, image, email;
    late double lat, lon;
    

    RecycleCenter(name, address,phone,image, email, lat, lon){
        this.name=name;
        this.address=address;
        this.phone=phone;
        this.image=image;
        this.email=email;
        this.lat=lat;
        this.lon=lon;
    }

    static Future getCenterList() async {
    // Get docs from collection reference
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('RecycleCenter');
      List centerList=[];
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    centerList = querySnapshot.docs.map((doc) => doc.data()).toList();

    return centerList;
}

    
   

  

}