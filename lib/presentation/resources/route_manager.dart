import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_admin/presentation/banners/add_banner/add_banner_view.dart';
import 'package:food_admin/presentation/banners/edit_banner/edit_banner_view.dart';
import 'package:food_admin/presentation/banners/get_all_banners/get_all_banners_view.dart';
import 'package:food_admin/presentation/category/all_categories/all_categories_view.dart';
import 'package:food_admin/presentation/home/home_view.dart';
import 'package:food_admin/presentation/products/add_product/add_product_view.dart';
import 'package:food_admin/presentation/resources/string_manager.dart';

import '../category/add_category/add_category_view.dart';
import '../login/login_view.dart';
import '../splash/spalsh_view.dart';



class AppRoutes{
  static const String splashRoute= '/splash';
  static const String loginRoute= '/login';
  static const String registerRoute= '/register';
  static const String addBannerRoute= '/addBanner';
  static const String allBannersRoute= '/allBanners';
  static const String editBannerRoute= '/editBanner';
  static const String homeRoute= '/home';
  static const String notificationRoute= '/notification';
  static const String addProductRoute= '/addProduct';
  static const String editProductRoute= '/editProduct';
  static const String allProductRoute= '/allProducts';
  static const String profileRoute= '/profile';
  static const String mostPopularRoute= '/mostPopular';
  static const String addCategoryRoute= '/addCategory';
  static const String editCategoryRoute= '/editCategory';
  static const String allCategoriesRoute= '/allCategories';







}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case AppRoutes.homeRoute :
          return MaterialPageRoute(builder:(context)=>const HomeView());
      // case AppRoutes.notificationRoute :
    //     return MaterialPageRoute(builder:(context)=>const NotificationView());
      case AppRoutes.addProductRoute :
        return MaterialPageRoute(builder:(context)=>const AddProductView());
    //   case AppRoutes.profileRoute :
    //     return MaterialPageRoute(builder:(context)=>const ProfileView());
      case AppRoutes.addBannerRoute :
        return MaterialPageRoute(builder:(context)=>  const AddBannerView());
    case AppRoutes.loginRoute :
        return MaterialPageRoute(builder:(context)=>  const LoginView());
      case AppRoutes.editBannerRoute :
        return MaterialPageRoute(builder:(context)=>   const EditBannerView());
      case AppRoutes.allBannersRoute :
        return MaterialPageRoute(builder:(context)=>  const AllBannersView());
    //   case AppRoutes.registerRoute :
    //     return MaterialPageRoute(builder:(context)=> const RegistrationView());
      case AppRoutes.splashRoute :
        return MaterialPageRoute(builder:(context)=>const SplashView());
      case AppRoutes.allCategoriesRoute :
        return MaterialPageRoute(builder:(context)=>const AllCategoriesView());
      case AppRoutes.addCategoryRoute :
        return MaterialPageRoute(builder:(context)=>const AddCategoryView());


        default:
          return undefinedRoute();

    }
  }

  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: (context)=> const Scaffold(
      body: Text(AppStrings.errorRoute),
    ));
  }
}