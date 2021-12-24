import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/views/widgets/custom.textfield.dart';
import 'package:yoursevice/views/widgets/loading.dialog.dart';

class CadastroServicoPageOne extends StatefulWidget {
  const CadastroServicoPageOne({Key key}) : super(key: key);

  @override
  _CadastroServicoPageOneState createState() => _CadastroServicoPageOneState();
}

class _CadastroServicoPageOneState extends State<CadastroServicoPageOne> {
  GlobalKey<FormState> solicitForm = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  final nome = TextEditingController();
  final desc = TextEditingController();
  final categoria = TextEditingController();
  var perfilController = Modular.get<PerfilController>();

  bool card = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Servico'),
          leading: Container(),
        ),
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
                      child: Text('Titulo do Servico'),
                    ),
                    CustomTextField(
                      controller: nome,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Descrição'),
                    ),
                    CustomTextField(
                      controller: desc,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Categoria'),
                    ),
                    CustomTextField(
                      controller: categoria,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    CheckboxListTile(
                        value: card,
                        title: Text('Aceita Cartão'),
                        onChanged: (value) {
                          setState(() {
                            card = value;
                            print(card);
                          });
                        }),
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
                              perfilController.servico = 0;

                              db
                                  .collection('servico')
                                  .add({
                                    'nome': nome.text,
                                    'descricao': desc.text,
                                    'categoria': categoria.text,
                                    'card': card,
                                    'email': auth.currentUser.email,
                                    'telefone': perfilController.phone.text
                                  })
                                  .then((value) {})
                                  .whenComplete(() {
                                    Modular.to.pop();
                                    perfilController.servico == 1
                                        ? Modular.to.pushReplacementNamed(
                                            '/main-navigation')
                                        : Modular.to.popUntil(
                                            ModalRoute.withName(
                                                '/main-navigation'));
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
