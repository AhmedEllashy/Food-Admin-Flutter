// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/category_bloc/category_cubit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/logic/product_bloc/product_cubit.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../resources/widgets_manager.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({Key? key}) : super(key: key);

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final _categoryNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool imageChoosed = false;
  String? imageUrl;
  File? image;

  @override
  Widget build(BuildContext context) {
    return _getContentScreen(context);
  }

  Widget _getContentScreen(BuildContext mainContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.addCategory,
          style: getMediumTextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if(state is AddCategoryLoadingState){
            showLoadingDialog(mainContext);
            }
            if(state is AddCategoryFailedState){
              getFlashBar(state.message, context);
            }
            if(state is AddCategoryCompletedState){
              _categoryNameController.clear();
              setState(() {
                imageChoosed = false;
              });
                Navigator.of(context, rootNavigator: true).pop();

              getFlashBar(AppStrings.success, context,backgroundColor: Colors.green);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(AppSize.s12),
              child: Column(
                children: [
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  Form(
                    key: _formKey,
                    child: AppTextFormField(
                      _categoryNameController,
                      hint: AppStrings.categoryName,
                      showBorder: true,
                    ),
                  ),
                  Row(
                    children: [
                      AppButton(
                        AppStrings.browse,
                            () {
                          pickImage();
                        },
                        width: AppSize.s120,

                      ),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      imageChoosed
                          ? Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text(
                            AppStrings.imageAddedSuccessfully,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  AppButton(AppStrings.save, () async{
                   if(_formKey.currentState!.validate()){
                     await uploadImage();
                     CategoryCubit.get(context)
                         .addCategory(_categoryNameController.text, imageUrl!);

                   }
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
    await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
      imageChoosed = true;
    });
  }

  Future<void> uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference =
    storage.ref().child('/categories/${CategoryCubit
        .get(context)
        .categoryId}');
    TaskSnapshot uploadImage = await reference.putFile(image!);
    String url = await uploadImage.ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }
}
