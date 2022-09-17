import 'package:cloud_firestore/cloud_firestore.dart';

class BannerDataModel {
  String id;
  String imageUrl;

  BannerDataModel({required this.id, required this.imageUrl});

  factory BannerDataModel.fromFireStore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    return BannerDataModel(id: data["id"], imageUrl: data["bannerImageUrl"]);
  }
}
