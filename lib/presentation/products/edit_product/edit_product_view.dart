import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_admin/domain/logic/product_bloc/product_cubit.dart';
import 'package:food_admin/domain/logic/product_bloc/product_states.dart';
import 'package:food_admin/presentation/resources/color_manager.dart';
import 'package:food_admin/presentation/resources/string_manager.dart';
import 'package:food_admin/presentation/resources/styles_manager.dart';
import 'package:food_admin/presentation/resources/widgets_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../resources/values_manager.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({Key? key}) : super(key: key);

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productCategoryController =
  TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDiscountController =
  TextEditingController();
  final TextEditingController _productStatusController =
  TextEditingController();
  final TextEditingController _productAmountController =
  TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool imageChoosed = false;
  String? imageUrl;
  File? image;



  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.addProduct,
          style: getMediumTextStyle(),
        ),
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if(state is AddProductFailedState){
            getFlashBar(state.message, context);
            debugPrint("error : ${state.message}");
          }
          if(state is AddProductCompletedState){
            getFlashBar(AppStrings.success, context,backgroundColor: Colors.green);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSize.s20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  AppTextFormField(
                    _productNameController,
                    hint: AppStrings.prodName,
                    showBorder: true,
                  ),
                  AppTextFormField(
                    _productCategoryController,
                    hint: AppStrings.category,
                    showBorder: true,
                  ),
                  AppTextFormField(
                    _productPriceController,
                    hint: AppStrings.price,
                    showBorder: true,
                  ),
                  AppTextFormField(
                    _productDiscountController,
                    hint: AppStrings.discount,
                    showBorder: true,
                  ),
                  AppTextFormField(
                    _productStatusController,
                    hint: AppStrings.status,
                    showBorder: true,
                  ),
                  AppTextFormField(
                    _productAmountController,
                    hint: AppStrings.amount,
                    showBorder: true,
                  ),
                  Row(
                    children: [
                      AppButton(AppStrings.browse, () {
                        pickImage();
                      },width: AppSize.s120,),
                      const SizedBox(width: AppSize.s8,),
                      imageChoosed ? Row(
                        children: const [
                          Icon(Icons.check_circle,color: Colors.green,),
                          Text(AppStrings.imageAddedSuccessfully,overflow: TextOverflow.ellipsis,),
                        ],
                      ):

                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  state is AddProductLoadingStateState ? const Center(child:  CircularProgressIndicator()) :AppButton(AppStrings.addProduct, () {
                    addProduct();
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  addProduct() async{
    await uploadImage();
    if (_formKey.currentState!.validate()) {
      ProductCubit.get(context).addProduct(
        ProductCubit.get(context).prodId,
        _productNameController.text,
        _productCategoryController.text,
        _productPriceController.text,
        _productDiscountController.text,
        _productStatusController.text,
        int.parse(_productAmountController.text,),
        imageUrl!,
      );

      setState(() {
        _productNameController.clear();
        _productCategoryController.clear();
        _productPriceController.clear();
        _productDiscountController.clear();
        _productStatusController.clear();
        _productAmountController.clear();
        imageChoosed = false;
        ProductCubit.get(context).prodId = Uuid().v4();
      });
    }
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
    storage.ref().child('/products/${ProductCubit.get(context).prodId}');
    TaskSnapshot uploadImage = await reference.putFile(image!);
    String url = await uploadImage.ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }
}
