import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/banner_bloc/banner_state.dart';
import 'package:food_admin/domain/models/banner.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/logic/banner_bloc/banner_cubit.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../../resources/widgets_manager.dart';

class EditBannerView extends StatefulWidget {
  final BannerDataModel? banner;
  const EditBannerView({Key? key, this.banner}) : super(key: key);

  @override
  State<EditBannerView> createState() => _EditBannerViewState();
}

class _EditBannerViewState extends State<EditBannerView> {
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
          AppStrings.editBanner,
          style: getMediumTextStyle(color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s12),
          child: BlocConsumer<BannerCubit, BannerState>(
            listener: (cxt, state) {
              if (state is EditBannerCompletedState) {
                getFlashBar(AppStrings.success, context,
                    backgroundColor: Colors.green);
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();

                });

              }
              if (state is EditBannerFailedState) {
                getFlashBar(state.message, context);
              }
            },
  builder: (context, state) {
    return Stack(
            children: [_bannerWidget(), _updateButton(state)],
          );
  },
),
        ),
      ),
    );
  }

  Widget _bannerWidget() {
    return InkWell(
      onTap: () {
        pickImage();
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        child: image?.path != null
            ? Image.asset(
                image!.path,
                fit: BoxFit.cover,
          height: AppSize.s160,
          width: double.infinity,
              )
            : CachedNetworkImage(
                height: AppSize.s160,
                width: double.infinity,
                imageUrl: widget.banner!.imageUrl,
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
    );
  }

  Widget _updateButton(state) {
          return state is EditBannerLoadingState ?const Center(
            child: CircularProgressIndicator(),
          ) : Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(AppStrings.update, () async {
                if (image?.path == null) {
                  getFlashBar(AppStrings.success, context,
                      backgroundColor: Colors.green);
                } else {
                  await uploadImage();
                  BannerCubit.get(context)
                      .editBanner(widget.banner!.id, imageUrl!);
                  getFlashBar(AppStrings.success, context,
                      backgroundColor: Colors.green);

                }
              }));


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
