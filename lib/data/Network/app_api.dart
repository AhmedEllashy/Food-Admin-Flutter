import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_admin/data/firebase_paths.dart';
import 'package:uuid/uuid.dart';

class AppServiceClient {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;




  Future<void> addProduct(String prodId,String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus,int amount,String imageUrl) async {
  try{
    await _db.collection(FireStoreConstants.products).doc(prodId).set({
      "id": prodId,
      "name":prodName,
      "category":prodCategory,
      "price" : prodPrice,
      "discount":prodDiscount,
      "status" : prodStatus,
      "amount": amount,
      "imageUrl":imageUrl,


    });
  } catch(e){
    throw(e.toString());
  }
  }
  Future<void> editProduct(String prodId,String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus,int amount,String imageUrl) async {
    try{
      await _db.collection(FireStoreConstants.products).doc(prodId).set({
        "id": prodId,
        "name":prodName,
        "category":prodCategory,
        "price" : prodPrice,
        "discount":prodDiscount,
        "status" : prodStatus,
        "amount": amount,
        "imageUrl":imageUrl,


      });
    } catch(e){
      throw(e.toString());
    }
  }

  Future<List<dynamic>> getAllProducts() async {
    try{
      final products = await _db.collection(FireStoreConstants.products).get();
      return products.docs;
    } catch(e){
      throw(e.toString());
    }
  }
  Future<void> addBanner(String bannerId ,String bannerImageUrl) async {
    try{
      await _db.collection(FireStoreConstants.banners).doc(bannerId).set({
        "id": bannerId,
        "bannerImageUrl":bannerImageUrl,
      });
    } catch(e){
      throw(e.toString());
    }
  }
  Future<void> editBanner(String bannerId ,String bannerImageUrl) async {
    try{
      await _db.collection(FireStoreConstants.banners).doc(bannerId).set({
        "id": bannerId,
        "bannerImageUrl":bannerImageUrl,
      });
    } catch(e){
      throw(e.toString());
    }
  }
  Future<void> removeBanner(String bannerId) async {
    try{
      Reference reference =
      storage.ref().child('/banners/$bannerId');
      await reference.delete();

      await _db.collection(FireStoreConstants.banners).doc(bannerId).delete();

    } catch(e){
      throw(e.toString());
    }
  }
  Future<List<dynamic>> getAllBanners()async{
    final banners = await _db.collection(FireStoreConstants.banners).get();
    return banners.docs;
  }


Future<void> addCategory(String categoryId , String name,String imageUrl) async {
  try{
    await _db.collection(FireStoreConstants.category).doc(categoryId).set({
      "id": categoryId,
      "name" : name,
      "imageUrl":imageUrl,
    });
  } catch(e){
    throw(e.toString());
  }
}
Future<void> editCategory(String categoryId , String name,String imageUrl) async {
  try{
    await _db.collection(FireStoreConstants.category).doc(categoryId).set({
      "id": categoryId,
      "name" : name,
      "imageUrl":imageUrl,
    });
  } catch(e){
    throw(e.toString());
  }
}
Future<void> removeCategory(String categoryId) async {
  try{
    Reference reference =
    storage.ref().child('/categories/$categoryId');
    await reference.delete();

    await _db.collection(FireStoreConstants.category).doc(categoryId).delete();

  } catch(e){
    throw(e.toString());
  }
}
Future<List<dynamic>> getAllCategories()async{
  final categories = await _db.collection(FireStoreConstants.category).get();
  return categories.docs;
  }
}