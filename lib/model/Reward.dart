

class Reward {
  late String id;
  late String title;
  late String description;
  late int quantity;
  late int point;


   Reward(
      {this.id = '',
      this.title= '',
      this.description = '',
      this.quantity= 0,
      this.point =0,
      });


  static Reward fromJson(String docId, Map<String, dynamic> json) {
   
    Reward reward=Reward(
    id:docId,
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      point: json['redeemPoint']);
      
      return reward;
}
}
