class Listing {
  late String title, category, condition, description, method, image;
  late String documentId;
  late String price;
  late String seller;
  late String sellerID;

  Listing(
      {this.title = '',
      this.category = '',
      this.condition = '',
      this.description = '',
      this.method = '',
      this.image = '',
      this.documentId = '',
      this.price = '',
      this.seller = '',
      this.sellerID = ''});

  static Listing fromJson(String id, Map<String, dynamic> json) => Listing(
      title: json['title'],
      category: json['category'],
      condition: json['condition'],
      description: json['description'],
      method: json['method'],
      image: json['image'],
      price: json['price'],
      documentId: id,
      sellerID: json['sellerID'],
      seller: json['seller']);
}
