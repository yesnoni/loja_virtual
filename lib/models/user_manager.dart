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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user;

  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;


  Future<void> signIn({Usuario user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password,
      );

     //await _loadCurrentUser(firebaseUser: result.user);
      this.user = result.user;

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


      await user.saveData();

      onSuccess();

    }on FirebaseAuthException catch (e)  {
      onFail(getErrorString(e.code));
    }

    loading = false;


  }

  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser () async {
    final User currentUser =  auth.currentUser;

    if (currentUser != null) {

      final DocumentSnapshot docUser = await firestore.collection('users').doc(currentUser.uid).get();
      user = Usuario.fromDocument(docUser);


      notifyListeners();


    }

  }



}


