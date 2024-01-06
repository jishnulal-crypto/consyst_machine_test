import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_getx/product/models/category.model.dart';
import 'package:todo_app_getx/product/models/image.model.dart';

class Product {
  String? id;
  String? name;
  double? price;
  String? desc;
  int? quantity;
  String? userId;
  String? username;
  Category? category;
  List<ImageModel>? gallery;
  List<String>? likes;

  Product({
    this.id,
    this.name,
    this.price,
    this.desc,
    this.quantity,
    this.userId,
    this.username,
    this.category,
    this.gallery,
    this.likes,
  });

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    var data = Map.from(snap.data() as Map<String, dynamic>);
    return Product(
      id: snap.id,
      name: data["name"] ??
          '', // Use the null-aware operator ?? to provide a default value if 'name' is null
      price: (data["price"] as num?)?.toDouble() ??
          0.0, // Handle potential null and convert to double
      desc: data["desc"] ??
          '', // Use the null-aware operator ?? to provide a default value if 'desc' is null
      username: data["username"] ??
          '', // Use the null-aware operator ?? to provide a default value if 'username' is null
      userId: data["user_id"] ??
          '', // Use the null-aware operator ?? to provide a default value if 'user_id' is null
      gallery: (data["gallery"] as List<dynamic>?)
              ?.map((e) => ImageModel.fromJson(e))
              ?.toList() ??
          [], // Handle potential null and convert to List<ImageModel>
    );
  }

  toJson() {
    return {"name": name, "price": price, "desc": desc};
  }
}
