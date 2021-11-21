import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:yoursevice/Api/register.repository.dart';
import 'package:yoursevice/validators/validators.dart';

import 'package:yoursevice/views/widgets/custom.iconbutton.dart';
import 'package:yoursevice/views/widgets/custom.textfield.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String _email, _password;

  bool _isDoneRegister = false, _isDoneSignIn = false, _isLoadingSignIn = false;
  String _message = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var registroRepo = RegisterRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Faça seu cadastro aqui:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    validator: InputValidators.emailIsValid,
                    validatorText: 'Insira um texto válido',
                    hintText: 'Email',
                    onChange: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    validator: InputValidators.passwordIsValid,
                    validatorText: 'Insira um texto válido',
                    hintText: 'Password',
                    onChange: (value) {
                      _password = value;
                    },
                    isPasswordField: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _isDoneRegister || _isDoneSignIn
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
                              registroRepo
                                  .register(_email, _password)
                                  .whenComplete(() {})
                                  .then((value) {
                                setState(() {
                                  _isLoadingSignIn = false;
                                  _isDoneSignIn = true;
                                  print(_message);
                                  _message = value ?? '';
                                  if (_message ==
                                          'Cadastro feito com sucesso!' ??
                                      '') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // retorna um objeto do tipo Dialog
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          title: Text(
                                            "Aviso",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff223066),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                    'Conta criada com sucesso! Por favor,confirme seu e-mail.'),
                                                RaisedButton(
                                                  color: Color(0xff223066),
                                                  textColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32)),
                                                  child: Text(
                                                    "Fechar",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    Modular.to.popUntil(
                                                        ModalRoute.withName(
                                                            '/login'));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                              });
                            }
                          },
                          buttonWidth: 300,
                          title: 'Cadastrar',
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
