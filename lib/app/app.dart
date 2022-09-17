import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/domain/logic/banner_bloc/banner_cubit.dart';
import 'package:food_admin/domain/logic/product_bloc/product_cubit.dart';
import '../data/Repository/repository.dart';
import '../domain/logic/auth_bloc/auth_cubit.dart';
import '../domain/logic/category_bloc/category_cubit.dart';
import '../presentation/resources/route_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'app_prefs.dart';
import 'di.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// import 'di.dart';
class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp instance = MyApp._internal();

  factory MyApp()=> instance;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Repository _repository = instance<Repository>();
  final AppPreferences _appPreferences = instance<AppPreferences>();



  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_)=>AuthCubit(_repository,_appPreferences)),
        BlocProvider<ProductCubit>(create: (_)=>ProductCubit(_repository)),
        BlocProvider<BannerCubit>(create: (_)=>BannerCubit(_repository)),
        BlocProvider<CategoryCubit>(create: (_)=>CategoryCubit(_repository)),

      ],
      child: MaterialApp(
        initialRoute: AppRoutes.homeRoute,
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.getRoute,
        theme: getAppTheme(),
      ),
    );
  }
}
