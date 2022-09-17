import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDataModel {
  String id;
  String name;
  String imageUrl;

  CategoryDataModel(
      {required this.id, required this.name, required this.imageUrl});

  factory CategoryDataModel.fromFireStore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    return CategoryDataModel(
        id: data["id"],
        name: data["name"],
        imageUrl: data["imageUrl"]);
  }
}
