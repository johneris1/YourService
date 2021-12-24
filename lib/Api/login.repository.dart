import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';

class LoginRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  String message = '';
  var perfilController = Modular.get<PerfilController>();

  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = userCredential.additionalUserInfo.username;
      if (isEmailVerified()) {
        print('ok');
        message = 'ok';
        perfilController.getServicosUserGeral();
        perfilController.getInfo().whenComplete(() {
          print(perfilController.isOfffer);
          auth.currentUser.displayName != null
              ? Modular.to.popAndPushNamed('/main-navigation')
              : Modular.to.popAndPushNamed('/selec-user');
        });
      }
      return message ?? 'Confirme seu e-mail e tente fazer login novamente!';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Usuário não encontrado!';
      } else if (e.code == 'wrong-password') {
        message = 'Senha inválida ou Usuário inexistente!';
      }
      return message;
    }
  }

  Future redefinirSenha(String email) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      return message ?? 'E-mail não encontrado';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'Usuário não encontrado!';
      } else if (e.code == 'wrong-password') {
        message = 'Senha inválida ou Usuário inexistente!';
      }
      return message;
    }
  }

  Future logout(BuildContext context) async {
    try {
      auth.signOut();
      Modular.to.pushReplacementNamed('/login');
      Modular.to.popUntil(ModalRoute.withName('/login'));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Text(
              "Aviso",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff223066), fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Deslogado com sucesso'),
                  RaisedButton(
                    color: Color(0xff223066),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    child: Text(
                      "Fechar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Modular.to.pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );

      return 'Deslogado com sucesso';
    } on FirebaseAuthException catch (e) {
      message = e.code;
      return message;
    }
  }

  bool isEmailVerified() {
    User user = auth.currentUser;
    if (user.emailVerified == false) {
      user.sendEmailVerification();
    }
    return user.emailVerified;
  }
}
