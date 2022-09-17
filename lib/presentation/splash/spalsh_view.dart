import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';

import '../resources/route_manager.dart';


import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) async{
        if(await _appPreferences.getUserLoggedIn() ){
          Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);

        }else{
          Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);

        }

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return getContentScreen();
  }

}
Widget getContentScreen(){
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Image.asset(AppAssets.logo),
    ),
  );
}


