import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';

class SignUpScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Usuario user = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Criar conta",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Nome Completo",
                  ),
                  validator: (name){
                    if(name.isEmpty){
                      return "Campo obrigatório";
                    }else if(name.trim().split(" ").length <= 1){
                      return "Preencha seu nome completo";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (name){

                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email){
                    if(email.isEmpty){
                      return "Campo obrigatório";
                    }else if(!emailValid(email)){
                      return "E-mail inválido";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (email) => user.email = email,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Senha",
                  ),
                  obscureText: true,
                  validator: (pass){
                    if(pass.isEmpty){
                      return "Campo obrigatório";
                    }else if(pass.length < 6){
                      return "Senha muito curta";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (pass) => user.password = pass,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Repita a Senha",
                  ),
                  obscureText: true,
                  validator: (pass){
                    if(pass.isEmpty){
                      return "Campo obrigatório";
                    }else if(pass.length < 6){
                      return "Senha muito curta";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (pass) => user.confirmPassword = pass,
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                      onPressed: (){
                        if(formkey.currentState.validate()){
                          formkey.currentState.save();
                          if(user.password != user.confirmPassword){
                            scaffoldKey.currentState.showSnackBar(
                                const SnackBar(
                                  content: Text("Senhas não coincidem!"),
                                  backgroundColor: Colors.red,
                                )
                            );
                            return;
                          }
                        }
                      },
                    child: const Text(
                      "Criar Conta",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
