part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class AddCategoryCompletedState extends CategoryState {}

class AddCategoryLoadingState extends CategoryState {}

class AddCategoryFailedState extends CategoryState {
  String message;
  AddCategoryFailedState(this.message);
}

class GetAllCategoryCompletedState extends CategoryState {
  final List<CategoryDataModel> categories;
  GetAllCategoryCompletedState(this.categories);
}



class GetAllCategoryLoadingState extends CategoryState {}

class GetAllCategoryFailedState extends CategoryState {
  final String message;
  GetAllCategoryFailedState(this.message);
}

class EditCategoryCompletedState extends CategoryState {}

class EditCategoryLoadingState extends CategoryState {}

class EditCategoryFailedState extends CategoryState {
  final String message;
  EditCategoryFailedState(this.message);
}
class RemoveCategoryCompletedState extends CategoryState {}

class RemoveCategoryLoadingState extends CategoryState {}

class RemoveCategoryFailedState extends CategoryState {
  final String message;
  RemoveCategoryFailedState(this.message);
}