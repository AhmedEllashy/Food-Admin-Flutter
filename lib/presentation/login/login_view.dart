import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../resources/widgets_manager.dart';

import '../../domain/logic/auth_bloc/auth_cubit.dart';
import '../../domain/logic/auth_bloc/auth_states.dart';
import '../resources/color_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return getContentScreen();
  }

  Widget getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
          if (state is AuthSignWithGoogleSuccessState) {
            debugPrint('success');
          }
          if (state is AuthSignWithGoogleFailedState) {
            debugPrint(state.errorMessage);
            getFlashBar(state.errorMessage, context);
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSize.s14),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s60),
                    child: Text(
                      AppStrings.registrationTitle,
                      style: getBoldTextStyle(fontSize: AppFontSizes.f25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    AppStrings.loginDescription,
                    style: getRegularTextStyle(
                        color :AppColors.black.withOpacity(AppDecimal.d_6)),
                    // textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSize.s50,
                  ),
                  getTextsForm(),

                state is AuthSignInWitheEmailAndPasswordLoadingState?const CircularProgressIndicator():  AppButton(
                    AppStrings.login,
                    () {
                      login(state);
                    },
                    height: AppSize.s60,
                    radius: AppSize.s30,
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),


                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget getTextsForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
            _emailController,
            // Icons.email,
            hint: AppStrings.emailHint,
            label: AppStrings.email,
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          AppTextFormField(
            _passwordController,
            // Icons.lock,
            hint: AppStrings.passwordHint,
            isPassword: true,
            label: AppStrings.password,
          ),
          TextButton(
            onPressed: () {
              _formKey.currentState!.validate();
            },
            child: Text(
              AppStrings.forgotPassword,
              style: getRegularTextStyle(color :AppColors.primary),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }

  void login(state) {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      if (state is AuthSignInWitheEmailAndPasswordCompletedState) {
        Navigator.pushNamed(context, AppRoutes.homeRoute);
      }
      if (state is AuthSignInWitheEmailAndPasswordFailedState) {
        getFlashBar(state.errorMessage, context);
      }
    }
  }
}
