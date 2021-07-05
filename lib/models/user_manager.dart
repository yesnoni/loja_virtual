import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/usuario.dart';


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

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();

    } on FirebaseAuthException catch (e)  {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp({Usuario user, Function onFail, Function onSuccess}) async {

    loading = true;

    try{
      final UserCredential result = await  auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password
      );

      user.id = result.user.uid;
      this.user = user as User;

      await user.saveData();

      onSuccess();

    }on FirebaseAuthException catch (e)  {
      onFail(getErrorString(e.code));
    }

    loading = false;


  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser( {User firebaseUser} ) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      user = Usuario.fromDocument(docUser) as User;


      notifyListeners();
    }

  }



}


