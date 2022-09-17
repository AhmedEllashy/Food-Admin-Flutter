import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/product_bloc/product_cubit.dart';
import 'package:food_admin/domain/logic/product_bloc/product_states.dart';
import 'package:food_admin/presentation/resources/string_manager.dart';
import 'package:food_admin/presentation/resources/styles_manager.dart';
import 'package:food_admin/presentation/resources/values_manager.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({Key? key}) : super(key: key);

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  @override
  void initState() {
    super.initState();
    ProductCubit.get(context).getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GetAllProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetAllProductCompletedState) {
              final products = state.products;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Container();
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: AppSize.s16,
                      ),
                  itemCount: products.length);
            }else{
              return Center(child: Text(AppStrings.noData,style: getMediumTextStyle(),),);
            }
          },
        ),
      ),
    );
  }
}
