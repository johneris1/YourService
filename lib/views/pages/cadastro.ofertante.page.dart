import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/validators/validators.dart';
import 'package:yoursevice/views/widgets/custom.textfield.dart';
import 'package:yoursevice/views/widgets/loading.dialog.dart';

class CadastroOfertantePageOne extends StatefulWidget {
  const CadastroOfertantePageOne({Key key}) : super(key: key);

  @override
  _CadastroOfertantePageOneState createState() =>
      _CadastroOfertantePageOneState();
}

class _CadastroOfertantePageOneState extends State<CadastroOfertantePageOne> {
  GlobalKey<FormState> solicitForm = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var perfilController = Modular.get<PerfilController>();
  var db = FirebaseFirestore.instance;
  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final cep = TextEditingController();
  final telefone = TextEditingController();
  final nomeUser = TextEditingController();
  final cpf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(title: Text('Cadastro de Ofertante'), leading: Container()),
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
                      child: Text('CPF:'),
                    ),
                    CustomTextField(
                      controller: cpf,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
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
                                perfilController.phone.text = telefone.text;
                                auth.currentUser
                                    .updateProfile(displayName: nomeUser.text)
                                    .whenComplete(() {
                                  perfilController
                                      .deletIsBank()
                                      .whenComplete(() {
                                    db
                                        .collection('usuario')
                                        .add({
                                          'isOfertante': true,
                                          'nome': nome.text,
                                          'data_nascimento':
                                              dataNascimento.text,
                                          'email': auth.currentUser.email,
                                          'cep': cep.text,
                                          'telefone': telefone.text,
                                          'cpf': cpf.text
                                        })
                                        .then((value) {})
                                        .whenComplete(() {
                                          Modular.to.pop();
                                          Modular.to.pushReplacementNamed(
                                              '/selec-user/cadastro-servico');
                                        });
                                  });
                                });
                              })),
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
