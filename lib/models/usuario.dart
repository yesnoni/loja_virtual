import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario{

  Usuario.User({this.email, this.password, this.name, this.confirmPassword, this.id});

  Usuario.fromDocument(DocumentSnapshot document){

      id = document.id;
      name = document.get(['name']) as String;
      email = document.get(['email']) as String;
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async{
      await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'email': email,
      'name': name,
    };
  }

}