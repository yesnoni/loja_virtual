import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Usuario implements User{
  
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;



  CollectionReference  users = FirebaseFirestore.instance.collection('users');

  Usuario({this.email, this.password, this.name, this.confirmPassword, this.id});

  Usuario.fromDocument(DocumentSnapshot document) {

    id = document.id;
    //name = document.get(FieldPath([name])) as String;
    //name = document.get('name') as String;
    //email = document.get(FieldPath([email])) as String;
    //email  = document.get('email') as String;
    name = document['name'] as String;
    email = document['email'] as String;
    //name = users.doc(name).get() as String;
    //email = users.doc(email).get() as String;
  }
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

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement displayName
  String get displayName => throw UnimplementedError();

  @override
  // TODO: implement emailVerified
  bool get emailVerified => throw UnimplementedError();

  @override
  Future<String> getIdToken([bool forceRefresh = false]) {
    // TODO: implement getIdToken
    throw UnimplementedError();
  }

  @override
  Future<IdTokenResult> getIdTokenResult([bool forceRefresh = false]) {
    // TODO: implement getIdTokenResult
    throw UnimplementedError();
  }

  @override
  // TODO: implement isAnonymous
  bool get isAnonymous => throw UnimplementedError();

  @override
  Future<UserCredential> linkWithCredential(AuthCredential credential) {
    // TODO: implement linkWithCredential
    throw UnimplementedError();
  }

  @override
  Future<ConfirmationResult> linkWithPhoneNumber(String phoneNumber, [RecaptchaVerifier verifier]) {
    // TODO: implement linkWithPhoneNumber
    throw UnimplementedError();
  }

  @override
  // TODO: implement metadata
  UserMetadata get metadata => throw UnimplementedError();

  @override
  // TODO: implement phoneNumber
  String get phoneNumber => throw UnimplementedError();

  @override
  // TODO: implement photoURL
  String get photoURL => throw UnimplementedError();

  @override
  // TODO: implement providerData
  List<UserInfo> get providerData => throw UnimplementedError();

  @override
  Future<UserCredential> reauthenticateWithCredential(AuthCredential credential) {
    // TODO: implement reauthenticateWithCredential
    throw UnimplementedError();
  }

  @override
  // TODO: implement refreshToken
  String get refreshToken => throw UnimplementedError();

  @override
  Future<void> reload() {
    // TODO: implement reload
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification([ActionCodeSettings actionCodeSettings]) {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  // TODO: implement tenantId
  String get tenantId => throw UnimplementedError();

  @override
  // TODO: implement uid
  String get uid => throw UnimplementedError();

  @override
  Future<User> unlink(String providerId) {
    // TODO: implement unlink
    throw UnimplementedError();
  }

  @override
  Future<void> updateDisplayName(String displayName) {
    // TODO: implement updateDisplayName
    throw UnimplementedError();
  }

  @override
  Future<void> updateEmail(String newEmail) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword(String newPassword) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhoneNumber(PhoneAuthCredential phoneCredential) {
    // TODO: implement updatePhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhotoURL(String photoURL) {
    // TODO: implement updatePhotoURL
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile({String displayName, String photoURL}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<void> verifyBeforeUpdateEmail(String newEmail, [ActionCodeSettings actionCodeSettings]) {
    // TODO: implement verifyBeforeUpdateEmail
    throw UnimplementedError();
  }

}

