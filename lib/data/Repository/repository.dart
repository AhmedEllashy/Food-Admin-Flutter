

import 'package:food_admin/domain/models/banner.dart';
import 'package:food_admin/domain/models/product.dart';

import '../../domain/models/category.dart';
import '../Data_source/remote_data_source.dart';
import '../Network/local_errors.dart';
import '../Network/network_info.dart';

abstract class Repository{
  Future signInWithEmailAndPassword(String email ,String password);
  Future<void> addProduct(String prodId,String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus,int amount,String imageUrl);
  Future<void> editProduct(String prodId,String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus,int amount,String imageUrl);
  Future<List<Product>> getAllProducts();
  Future<void> addBanner(String bannerId,String bannerImageUrl);
  Future<List<BannerDataModel>> getAllBanners();
  Future<void> editBanner(String bannerId ,String bannerImageUrl);
  Future<void> removeBanner(String bannerId);
  Future<void> addCategory(String id,String name, String imageUrl);
  Future<List<CategoryDataModel>> getAllCategories();
  Future<void> editCategory(String id,String name, String imageUrl);
  Future<void> removeCategory(String id);



}
class RepositoryImplementer implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;

  RepositoryImplementer(this._networkInfo, this._remoteDataSource);

  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    if (await _networkInfo.isConnected) {
      return await _remoteDataSource.signInWithEmailAndPassword(
          email, password);
    } else {
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future<void> addProduct(String prodId, String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus, int amount,
      String imageUrl) async {
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.addProduct(
          prodId,
          prodName,
          prodCategory,
          prodPrice,
          prodDiscount,
          prodStatus,
          amount,
          imageUrl);
    } else {
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future<void> addBanner(String bannerId, String bannerImageUrl) async {
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.addBanner(bannerId, bannerImageUrl);
    } else {
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future<List<BannerDataModel>> getAllBanners() async {
    if (await _networkInfo.isConnected) {
      final banners = await _remoteDataSource.getAllBanners();
      return banners.map((banner) => BannerDataModel.fromFireStore(banner))
          .toList();
    } else {
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future<void> editBanner(String bannerId, String bannerImageUrl) async {
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.editBanner(bannerId, bannerImageUrl);
    } else {
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future<void> removeBanner(String bannerId) async {
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.removeBanner(bannerId);
    } else {
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future<void> addCategory(String id, String name, String imageUrl) async {
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.addCategory(id, name, imageUrl);
    } else {
      throw(ErrorMessages.internetError);
    }
  }

    @override
    Future<void> editCategory(String id, String name, String imageUrl) async {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.editCategory(id, name, imageUrl);
      } else {
        throw(ErrorMessages.internetError);
      }
    }

    @override
    Future<List<CategoryDataModel>> getAllCategories() async {
      if (await _networkInfo.isConnected) {
        final categories = await _remoteDataSource.getAllCategories();
        return categories.map((category) =>
            CategoryDataModel.fromFireStore(category)).toList();
      } else {
        throw(ErrorMessages.internetError);
      }
    }

    @override
    Future<void> removeCategory(String id) async {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.removeCategory(id);
      } else {
        throw(ErrorMessages.internetError);
      }
    }

  @override
  Future<void> editProduct(String prodId, String prodName, String prodCategory, String prodPrice, String prodDiscount, String prodStatus, int amount, String imageUrl
      ) async{
    if (await _networkInfo.isConnected) {
      await _remoteDataSource.editProduct(prodId, prodName, prodCategory, prodPrice, prodDiscount, prodStatus, amount, imageUrl);
    } else {
      throw(ErrorMessages.internetError);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async{
    if (await _networkInfo.isConnected) {
      final products = await _remoteDataSource.getAllProducts();
      return products.map((product) => Product.formJson(product)).toList();
    } else {
      throw(ErrorMessages.internetError);
    }
  }

}