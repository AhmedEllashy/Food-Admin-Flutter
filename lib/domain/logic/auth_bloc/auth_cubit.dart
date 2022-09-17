import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../app/app_prefs.dart';
import '../../../data/Repository/repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final Repository _repository;
  final AppPreferences _appPreferences;
  AuthCubit(this._repository,this._appPreferences) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  Future signInWithEmailAndPassword(String email ,String password)async{
    emit(AuthSignInWitheEmailAndPasswordLoadingState());
  try{
    try{
      await _repository.signInWithEmailAndPassword(email, password);
      emit(AuthSignInWitheEmailAndPasswordCompletedState());
      _appPreferences.setUserLoggedIn();

    }catch(e){
      emit(AuthSignInWitheEmailAndPasswordFailedState(e.toString()));
    }
  }on FirebaseAuthException catch(e){
    emit(AuthSignInWitheEmailAndPasswordFailedState(e.message.toString()));

  }

  }

}
