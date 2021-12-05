import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/validators/validators.dart';
import 'package:yoursevice/views/widgets/custom.textfield.dart';
import 'package:yoursevice/views/widgets/loading.dialog.dart';

class PerfilPageOne extends StatefulWidget {
  const PerfilPageOne({Key key}) : super(key: key);

  @override
  _PerfilPageOneState createState() => _PerfilPageOneState();
}

class _PerfilPageOneState extends State<PerfilPageOne> {
  GlobalKey<FormState> solicitForm = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var perfilController = Modular.get<PerfilController>();

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
                      controller: perfilController.nome,
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
                      controller: perfilController.nomeUser,
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
                      controller: perfilController.dataNascimento,
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
                      controller: perfilController.cep,
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
                      controller: perfilController.telefone,
                      validator: InputValidators.phoneIsValid,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        LoadingDialog(context);
                        perfilController.deletSolicitante();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Quer apagar sua conta? '),
                          Text(
                            ' Clique aqui',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blue,
                        ),
                        child: MaterialButton(
                            child: Text('Salvar'),
                            onPressed: () {
                              print('oi');
                              LoadingDialog(context);
                              perfilController.updatePerfil();
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
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
