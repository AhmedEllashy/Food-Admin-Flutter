import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/category_bloc/category_cubit.dart';
import 'package:food_admin/domain/logic/product_bloc/product_states.dart';
import 'package:uuid/uuid.dart';

import '../../../data/Repository/repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final Repository _repository;
  ProductCubit(this._repository) : super(ProductInitialStates());
  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);
  var prodId = const Uuid().v4();

  Future<void> addProduct(
      String prodId,
      String prodName,
      String prodCategory,
      String prodPrice,
      String prodDiscount,
      String prodStatus,
      int amount,
      String imageUrl) async {
    emit(AddProductLoadingStateState());
    try {
      await _repository.addProduct(prodId, prodName, prodCategory, prodPrice,
          prodDiscount, prodStatus, amount, imageUrl);
      emit(AddProductCompletedState());
    } catch (e) {
      emit(AddProductFailedState(e.toString()));
    }
  }

  Future<void> editProduct(
      String prodId,
      String prodName,
      String prodCategory,
      String prodPrice,
      String prodDiscount,
      String prodStatus,
      int amount,
      String imageUrl) async {
    emit(AddProductLoadingStateState());
    try {
      await _repository.addProduct(prodId, prodName, prodCategory, prodPrice,
          prodDiscount, prodStatus, amount, imageUrl);
      emit(AddProductCompletedState());
    } catch (e) {
      emit(AddProductFailedState(e.toString()));
    }
  }

  Future<void> getAllProducts() async {
    emit(GetAllProductLoadingState());
    await _repository
        .getAllProducts()
        .then((products) => emit(GetAllProductCompletedState(products)),
            onError: (e) => emit(
                  GetAllProductFailedState(e.toString()),
                ));
  }
}
