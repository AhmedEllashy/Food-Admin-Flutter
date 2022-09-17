import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../data/Repository/repository.dart';
import '../../models/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final Repository _repository;
  CategoryCubit(this._repository) : super(GetAllCategoryLoadingState());
  String categoryId = const Uuid().v4();
  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);

  void addCategory(String name,String imageUrl) {
    emit(AddCategoryLoadingState());
    _repository.addCategory(categoryId,name ,imageUrl).then((_) {
      emit(AddCategoryCompletedState());
      categoryId = const Uuid().v4();
    }, onError: (e) {
      emit(AddCategoryFailedState(e.toString()));
    });
  }

  void getAllCategories() {
    GetAllCategoryLoadingState();
    _repository.getAllCategories().then(
            (categories) => emit(GetAllCategoryCompletedState(categories)),
        onError: (e) => emit(GetAllCategoryFailedState(e.toString())));
  }

  void editCategory(String id,String name,String imageUrl) {
    emit(EditCategoryLoadingState());
    _repository.editCategory(id, name ,imageUrl ).then((_) {
      emit(EditCategoryCompletedState());
    }, onError: (e) {
      emit(EditCategoryFailedState(e.toString()));
    });
  }
  void removeCategory(String id) {
    emit(RemoveCategoryLoadingState());
    _repository.removeCategory(id).then((_) {
      emit(RemoveCategoryCompletedState());
      getAllCategories();
    }, onError: (e) {
      emit(RemoveCategoryFailedState(e.toString()));
    });
  }
}
