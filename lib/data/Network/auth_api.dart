import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';

class AuthApi {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late UserCredential user;

  Future signInWithEmailAndPassword(String email ,String password)async{
    UserCredential user =  await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

}
