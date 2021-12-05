import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/validators/validators.dart';
import 'package:yoursevice/views/widgets/custom.textfield.dart';
import 'package:yoursevice/views/widgets/loading.dialog.dart';

class CadastroSolicitantePageOne extends StatefulWidget {
  const CadastroSolicitantePageOne({Key key}) : super(key: key);

  @override
  _CadastroSolicitantePageOneState createState() =>
      _CadastroSolicitantePageOneState();
}

class _CadastroSolicitantePageOneState
    extends State<CadastroSolicitantePageOne> {
  GlobalKey<FormState> solicitForm = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final cep = TextEditingController();
  final telefone = TextEditingController();
  final nomeUser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: solicitForm,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Nome:'),
                    ),
                    CustomTextField(
                      controller: nome,
                      validator: InputValidators.nameCompletIsValid,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Nome de Usuario:'),
                    ),
                    CustomTextField(
                      controller: nomeUser,
                      validator: InputValidators.nameUserIsValid,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Data de Nascimento:'),
                    ),
                    CustomTextField(
                      controller: dataNascimento,
                      validator: InputValidators.dateIsValid,
                      validatorText: 'Insira um texto válido',
                      hintText: 'Data de Nascimento',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Cep:'),
                    ),
                    CustomTextField(
                      controller: cep,
                      validator: InputValidators.cepIsValid,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Telefone:'),
                    ),
                    CustomTextField(
                      controller: telefone,
                      validator: InputValidators.phoneIsValid,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                        ),
                        child: MaterialButton(
                            child: Text('Cadastrar'),
                            onPressed: () {
                              LoadingDialog(context);
                              auth.currentUser
                                  .updateProfile(displayName: nomeUser.text)
                                  .whenComplete(() {
                                print(auth.currentUser.displayName);
                                db
                                    .collection('solicitante')
                                    .add({
                                      'nome': nome.text,
                                      'data_nascimento': dataNascimento.text,
                                      'email': auth.currentUser.email,
                                      'cep': cep.text,
                                      'telefone': telefone.text,
                                    })
                                    .then((value) {})
                                    .whenComplete(() {
                                      Modular.to.pop();
                                      Modular.to.pushReplacementNamed(
                                          '/main-navigation');
                                    });
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
