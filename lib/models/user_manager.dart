import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual/models/user.dart';


class UserManager {

  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> signIn(Usuario usuario) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.password,
      );

    } on FirebaseAuthException catch (e, s) {_handleFirebaseLoginWithCredentialsException(e, s);
    } on Exception {
      //Outro problema
      return 'Problema desconhecido';
    }
  }

  String _handleFirebaseLoginWithCredentialsException(
      FirebaseAuthException e, StackTrace s) {
    if (e.code == 'user-disabled') {
      return 'O usuário informado está desabilitado.';
    } else if (e.code == 'user-not-found') {
      return 'O usuário informado não está cadastrado.';
    } else if (e.code == 'invalid-email') {
      return 'O domínio do e-mail informado é inválido.';
    } else if (e.code == 'wrong-password') {
      return 'A senha informada está incorreta.';
    } else {
      return 'Erro inexperado';
    }
  }
}


