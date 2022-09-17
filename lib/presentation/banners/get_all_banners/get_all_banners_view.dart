import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/banner_bloc/banner_cubit.dart';
import 'package:food_admin/domain/logic/banner_bloc/banner_state.dart';
import 'package:food_admin/domain/models/banner.dart';
import 'package:food_admin/presentation/banners/edit_banner/edit_banner_view.dart';
import 'package:food_admin/presentation/resources/assets_manager.dart';
import 'package:food_admin/presentation/resources/color_manager.dart';
import 'package:food_admin/presentation/resources/route_manager.dart';
import 'package:food_admin/presentation/resources/values_manager.dart';
import 'package:food_admin/presentation/resources/widgets_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/string_manager.dart';
import '../../resources/styles_manager.dart';

class AllBannersView extends StatefulWidget {
  const AllBannersView({Key? key}) : super(key: key);

  @override
  State<AllBannersView> createState() => _AllBannersViewState();
}

class _AllBannersViewState extends State<AllBannersView> {
  @override
  void initState() {
    super.initState();
    BannerCubit.get(context).getAllBanners();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen(context);
  }

  Widget _getContentScreen(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.banners,
          style: getMediumTextStyle(color: AppColors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addBannerRoute);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: BlocConsumer<BannerCubit, BannerState>(
          listener: (context, state) {
            if (state is GetAllBannerFailedState) {
              getFlashBar(state.message, context);
            }
            if (state is RemoveBannerFailedState) {
              getFlashBar(state.message, context);
            }
            if (state is RemoveBannerCompletedState) {
              getFlashBar(AppStrings.success, context,backgroundColor: Colors.green);
            }
          },
          builder: (context, state) {
            if (state is GetAllBannerCompletedState) {
              final banners = state.banners;
              return banners.isNotEmpty ? ListView.separated(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return _bannerWidget(banners, index);

                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppSize.s20,
                ),
              ):  const Center(
                child: Text(AppStrings.noData),
              );
            } else if(state is RemoveBannerLoadingState || state is GetAllBannerLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }else{
              return const Center(
                child: Text(AppStrings.noData),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _bannerWidget(List<BannerDataModel> banners, int index) {
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
            imageUrl: banners[index].imageUrl,
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
                            EditBannerView(banner:banners[index]),),);
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
                backgroundColor:Colors.red,
                radius: AppSize.s20,
                child: IconButton(
                  onPressed: () {
                    BannerCubit.get(context).removeBanner(banners[index].id);
                    banners.remove(banners[index]);
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
      ],
    );
  }
}
