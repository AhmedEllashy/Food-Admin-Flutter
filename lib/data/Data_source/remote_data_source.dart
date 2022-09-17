
import '../Network/app_api.dart';
import '../Network/auth_api.dart';

abstract class RemoteDataSource{
  Future signInWithEmailAndPassword(String email ,String password);
  Future<void> addProduct(String prodId,String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus,int amount,String imageUrl);
  Future<void> editProduct(String prodId,String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus,int amount,String imageUrl);
  Future<List<dynamic>> getAllProducts();
  Future<void> addBanner(String bannerId,String bannerImageUrl);
  Future<List<dynamic>> getAllBanners();
  Future<void> editBanner(String bannerId ,String bannerImageUrl);
  Future<void> removeBanner(String bannerId);
  Future<void> addCategory(String id,String name, String imageUrl);
  Future<List<dynamic>> getAllCategories();
  Future<void> editCategory(String id,String name, String imageUrl);
  Future<void> removeCategory(String id);


}
class RemoteDataSourceImplementer implements RemoteDataSource {
  final AuthApi _authApi;
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._authApi,this._appServiceClient);


  @override
  Future signInWithEmailAndPassword(String email, String password) async{
    return await _authApi.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> addProduct(String prodId,String prodName, String prodCategory,
      String prodPrice, String prodDiscount, String prodStatus,int amount,String imageUrl) async{
    await _appServiceClient.addProduct(prodId,prodName, prodCategory, prodPrice, prodDiscount, prodStatus,amount,imageUrl);
  }

  @override
  Future<void> addBanner(String bannerId, String bannerImageUrl) async{
   await _appServiceClient.addBanner(bannerId, bannerImageUrl);
  }

  @override
  Future<List<dynamic>> getAllBanners() async{
    return await _appServiceClient.getAllBanners();
  }

  @override
  Future<void> editBanner(String bannerId, String bannerImageUrl) async{
    await _appServiceClient.editBanner(bannerId, bannerImageUrl);
  }

  @override
  Future<void> removeBanner(String bannerId) async{
    await _appServiceClient.removeBanner(bannerId);
  }
  @override
  Future<void> addCategory(String id,String name, String imageUrl) async{
    await _appServiceClient.addCategory(id,name, imageUrl);
  }
  @override
  Future<List<dynamic>> getAllCategories() async{
    return await _appServiceClient.getAllCategories();
  }
  @override
  Future<void> editCategory(String id,String name, String imageUrl)async{
    await _appServiceClient.editCategory(id,name, imageUrl);
  }

  @override
  Future<void> removeCategory(String id) async{
    await _appServiceClient.removeCategory(id);
  }

  @override
  Future<void> editProduct(String prodId, String prodName, String prodCategory, String prodPrice, String prodDiscount, String prodStatus, int amount, String imageUrl) async{
    await _appServiceClient.editProduct(prodId, prodName, prodCategory, prodPrice, prodDiscount, prodStatus, amount, imageUrl);
  }

  @override
  Future<List> getAllProducts() async{
   return await _appServiceClient.getAllProducts();
  }

}