import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';


class UserManager extends ChangeNotifier{

  UserManager(){
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  bool _loading = false;
  bool get loading => _loading;


  Future<void> signIn({Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: usuario.email,
          password: usuario.password
      );

      user = result.user;
      onSuccess();

    } on FirebaseAuthException catch (e)  {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final User currentUser = auth.currentUser;
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
    }
    notifyListeners();
  }



}


