import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/banner_bloc/banner_cubit.dart';
import 'package:food_admin/domain/logic/banner_bloc/banner_state.dart';
import 'package:food_admin/presentation/resources/assets_manager.dart';
import 'package:food_admin/presentation/resources/route_manager.dart';
import 'package:food_admin/presentation/resources/values_manager.dart';
import 'package:food_admin/presentation/resources/widgets_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/logic/product_bloc/product_cubit.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';

class AddBannerView extends StatefulWidget {
  const AddBannerView({Key? key}) : super(key: key);

  @override
  State<AddBannerView> createState() => _AddBannerViewState();
}

class _AddBannerViewState extends State<AddBannerView> {
  File? image;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.addBanner,
          style: getMediumTextStyle(color: AppColors.white),
        ),
      ),
      body: BlocConsumer<BannerCubit, BannerState>(
        listener: (context, state) {
          if (state is AddBannerFailedState) {
            getFlashBar(state.message, context);
          }
          if (state is AddBannerCompletedState) {
            getFlashBar(AppStrings.success, context,backgroundColor: Colors.green);

            Future.delayed(const Duration(seconds: 3),()=>Navigator.pushReplacementNamed(context, AppRoutes.allBannersRoute));
          }
        },
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(AppSize.s20),
          child: Stack(children: [
            InkWell(
              onTap: () {
                pickImage();
              },
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                ),
                child: image == null
                    ? Image.asset(
                        AppAssets.imageIcon,
                        height: AppSize.s160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        image!,
                        height: AppSize.s160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: state is AddBannerLoadingStateState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : AppButton(AppStrings.save, () async {
                        if (image == null) {
                          getFlashBar(AppStrings.pleaseSelectAnImage, context);
                        } else {
                          await uploadImage();
                          BannerCubit.get(context).addBanner(imageUrl!);
                          getFlashBar(AppStrings.success, context,
                              backgroundColor: Colors.green);
                        }
                      })),
          ]),
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
    });
  }

  Future<void> uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference =
        storage.ref().child('/banners/${BannerCubit.get(context).bannerId}');
    TaskSnapshot uploadImage = await reference.putFile(image!);
    String url = await uploadImage.ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }
}
