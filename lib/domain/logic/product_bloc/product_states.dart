import '../../models/product.dart';

abstract class ProductState {}

class ProductInitialStates extends ProductState {}

class AddProductCompletedState extends ProductState {}

class AddProductLoadingStateState extends ProductState {}

class AddProductFailedState extends ProductState {
  String message;
  AddProductFailedState(this.message);
}

class GetAllProductLoadingState extends ProductState {}
class GetAllProductCompletedState extends ProductState {
  List<Product> products;
  GetAllProductCompletedState(this.products);
}
class GetAllProductFailedState extends ProductState {
  String message;
  GetAllProductFailedState(this.message);
}

class EditProductCompletedState extends ProductState {}

class EditProductLoadingState extends ProductState {}

class EditProductFailedState extends ProductState {
  String message;
  EditProductFailedState(this.message);
}
class RemoveProductCompletedState extends ProductState {}

class RemoveProductLoadingState extends ProductState {}

class RemoveProductFailedState extends ProductState {
  String message;
  RemoveProductFailedState(this.message);
}