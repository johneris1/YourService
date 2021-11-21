import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/Api/login.repository.dart';
import 'package:yoursevice/validators/validators.dart';

import 'package:yoursevice/views/widgets/custom.iconbutton.dart';
import 'package:yoursevice/views/widgets/custom.textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final senha = TextEditingController();

  bool _isDoneSignIn = false, _isLoadingSignIn = false;
  String _message = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var loginRepo = LoginRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  // Text(
                  //   'Bem vindo ao',
                  //   style: TextStyle(
                  //       fontSize: 40,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.lightBlue),
                  // ),
                  Text(
                    'YourService',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: email,
                    validator: InputValidators.emailIsValid,
                    validatorText: 'Insira um texto válido',
                    hintText: 'Email',
                    onChange: (value) {},
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: senha,
                    validator: InputValidators.passwordIsValid,
                    validatorText: 'Insira um texto válido',
                    hintText: 'Password',
                    onChange: (value) {},
                    isPasswordField: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isDoneSignIn
                      ? SizedBox(
                          height: 30,
                          child: Text(_message),
                        )
                      : SizedBox(),
                  _isLoadingSignIn
                      ? Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onTapped: () {
                            if (formKey.currentState.validate()) {
                              setState(() {
                                _isLoadingSignIn = true;
                              });
                              loginRepo
                                  .signIn(email.text, senha.text)
                                  .whenComplete(() {})
                                  .then((value) {
                                setState(() {
                                  _isLoadingSignIn = false;
                                  _isDoneSignIn = true;
                                  print(_message);
                                  _message = value ?? '';
                                });
                              });
                            }
                          },
                          buttonWidth: 300,
                          title: 'Login',
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          email.clear();
                          senha.clear();
                          _message = '';
                          _isDoneSignIn = false;
                          _isLoadingSignIn = false;
                        });

                        Modular.to.pushNamed('/cadastro');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Novo por aqui? '),
                          Text(
                            ' Clique aqui',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ),
                        ],
                      )),
                  FlatButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          loginRepo.redefinirSenha(email.text);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Esqueceu sua senha? '),
                          Text(
                            ' Clique aqui',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
