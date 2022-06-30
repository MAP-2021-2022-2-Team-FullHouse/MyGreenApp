

class Reward {
  late String id;
  late String title;
  late String description;
  late int quantity;
  late int point;
  late String image;



   Reward(
      {this.id = '',
      this.title= '',
      this.description = '',
      this.quantity= 0,
      this.point =0,
      this.image=''
      });

  
  Map<String, dynamic> toJson() => {
       
        'title': title,
        'description': description,
        'quantity': quantity,
        'redeemPoint': point,
        'image':image,
     
     
        
      };

  static Reward fromJson(String docId, Map<String, dynamic> json) {
   
    Reward reward=Reward(
    id:docId,
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      point: json['redeemPoint'],
      image:json['image']);
      
      return reward;
}
}
