import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_admin/presentation/resources/assets_manager.dart';
import 'package:food_admin/presentation/resources/color_manager.dart';
import 'package:food_admin/presentation/resources/route_manager.dart';
import 'package:food_admin/presentation/resources/string_manager.dart';
import 'package:food_admin/presentation/resources/styles_manager.dart';
import 'package:food_admin/presentation/resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final ZoomDrawerController _drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      // controller:_drawerController,
      menuScreen: const MenuView(),
      mainScreen: const HomeScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: AppColors.primary.withOpacity(.9),
      shadowLayer1Color: AppColors.white.withOpacity(.8),
      menuBackgroundColor: AppColors.primary,
      // slideWidth: MediaQuery.of(context).size.width * 0.65,
      style: DrawerStyle.defaultStyle,
    );
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          AppStrings.dashboard,
          style: getMediumTextStyle(),
        ),
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle;
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.addProductRoute);
                  },
                  child: Container(
                    height: AppSize.s150,
                    width: AppSize.s150,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.productHunt,
                          size: AppSize.s60,
                          color: AppColors.primary,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Text(
                          AppStrings.products,
                          style: getMediumTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                Container(
                  height: AppSize.s150,
                  width: AppSize.s150,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSize.s20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home_filled,
                        size: AppSize.s60,
                        color: AppColors.primary,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(
                        AppStrings.category,
                        style: getMediumTextStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.allBannersRoute);
                  },
                  child: Container(
                    height: AppSize.s150,
                    width: AppSize.s150,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.productHunt,
                          size: AppSize.s60,
                          color: AppColors.primary,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Text(
                          AppStrings.banners,
                          style: getMediumTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                Container(
                  height: AppSize.s150,
                  width: AppSize.s150,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSize.s20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home_filled,
                        size: AppSize.s60,
                        color: AppColors.primary,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(
                        AppStrings.category,
                        style: getMediumTextStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MenuView extends StatelessWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: AppSize.s40,
          ),
          Image.asset(
            AppAssets.userIcon,
            height: AppSize.s100,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),

          Text(
            "Ahmad Ellashy",
            style: getMediumTextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: AppSize.s40,
          ),

          InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.allProductRoute);
              },
              child: ListTile(
                leading: const Icon(Icons.ac_unit,size: AppSize.s30,color: AppColors.white,),
                title: Text(
                  AppStrings.products,
                  style: getMediumTextStyle(color: Colors.white),
                ),
              )),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.allCategoriesRoute);

              },
              child: ListTile(
                leading: const Icon(Icons.home_filled,size: AppSize.s30,color: AppColors.white,),
                title: Text(
                  AppStrings.category,
                  style: getMediumTextStyle(color: Colors.white),
                ),
              )),
          InkWell(
              onTap: () {
                // Navigator.pushNamed(context, AppRoutes.allProductRoute);
              },
              child: ListTile(
                leading: const Icon(Icons.motorcycle_sharp,size: AppSize.s30,color: AppColors.white,),
                title: Text(
                  AppStrings.orders,
                  style: getMediumTextStyle(color: Colors.white),
                ),
              )),
          InkWell(
              onTap: () {},
              child: ListTile(
                leading: const Icon(Icons.chat,size: AppSize.s30,color: AppColors.white,),
                title: Text(
                  AppStrings.chat,
                  style: getMediumTextStyle(color: Colors.white),
                ),
              )),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.allBannersRoute);

              },
              child: ListTile(
                leading: const Icon(Icons.account_balance_sharp,size: AppSize.s30,color: AppColors.white,),
                title: Text(
                  AppStrings.banners,
                  style: getMediumTextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          AppStrings.dashboard,
          style: getMediumTextStyle(),
        ),
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.addProductRoute);
                  },
                  child: Container(
                    height: AppSize.s150,
                    width: AppSize.s150,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.productHunt,
                          size: AppSize.s60,
                          color: AppColors.primary,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Text(
                          AppStrings.products,
                          style: getMediumTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                Container(
                  height: AppSize.s150,
                  width: AppSize.s150,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSize.s20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home_filled,
                        size: AppSize.s60,
                        color: AppColors.primary,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(
                        AppStrings.category,
                        style: getMediumTextStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.allBannersRoute);
                  },
                  child: Container(
                    height: AppSize.s150,
                    width: AppSize.s150,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSize.s20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.productHunt,
                          size: AppSize.s60,
                          color: AppColors.primary,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Text(
                          AppStrings.banners,
                          style: getMediumTextStyle(),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                Container(
                  height: AppSize.s150,
                  width: AppSize.s150,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSize.s20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home_filled,
                        size: AppSize.s60,
                        color: AppColors.primary,
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(
                        AppStrings.category,
                        style: getMediumTextStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
