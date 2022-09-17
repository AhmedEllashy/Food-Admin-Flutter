import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/category_bloc/category_cubit.dart';
import 'package:food_admin/presentation/category/edit_category/edit_category_view.dart';
import 'package:food_admin/presentation/resources/assets_manager.dart';
import 'package:food_admin/presentation/resources/string_manager.dart';
import 'package:food_admin/presentation/resources/values_manager.dart';
import 'package:food_admin/presentation/resources/widgets_manager.dart';

import '../../../domain/models/category.dart';
import '../../resources/color_manager.dart';
import '../../resources/route_manager.dart';
import '../../resources/styles_manager.dart';

class AllCategoriesView extends StatefulWidget {
  const AllCategoriesView({Key? key}) : super(key: key);

  @override
  State<AllCategoriesView> createState() => _AllCategoriesViewState();
}

class _AllCategoriesViewState extends State<AllCategoriesView> {
  @override
  void initState() {
    super.initState();
    CategoryCubit.get(context).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.categories,
          style: getMediumTextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addCategoryRoute);
        },
      ),
      body: SafeArea(
        child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is GetAllCategoryFailedState) {
              getFlashBar(state.message, context);
            }
          },
          builder: (context, state) {
            if (state is GetAllCategoryCompletedState) {
              final categories = state.categories;
              if (categories.isEmpty) {
                return const Center(child: Text("No Categories Yet!"));
              } else {
                return Padding(
                    padding: const EdgeInsets.all(AppSize.s12),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return _categoryWidget(categories, index);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: AppSize.s20,
                            ),
                        itemCount: categories.length));
              }
            } else if (state is GetAllCategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text(AppStrings.noData),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _categoryWidget(List<CategoryDataModel> categories, index) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          child: CachedNetworkImage(
            height: AppSize.s160,
            width: double.infinity,
            imageUrl: categories[index].imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset(
              AppAssets.imageIcon,
              height: AppSize.s160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Image.asset(
              AppAssets.imageIcon,
              height: AppSize.s160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: AppSize.s20,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditCategoryView(category: categories[index]),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: AppSize.s20,
                child: IconButton(
                  onPressed: () {
                    CategoryCubit.get(context)
                        .removeCategory(categories[index].id);
                    categories.remove(categories[index]);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            categories[index].name,
            style: getMediumTextStyle(),
          ),
        ),
      ],
    );
  }
}
