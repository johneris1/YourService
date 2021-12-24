import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/views/widgets/custom.textfield.dart';
import 'package:yoursevice/views/widgets/loading.dialog.dart';

class EditServicoPage extends StatefulWidget {
  const EditServicoPage({Key key}) : super(key: key);

  @override
  _EditServicoPageState createState() => _EditServicoPageState();
}

class _EditServicoPageState extends State<EditServicoPage> {
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
          title: Text('Editar'),
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
                      controller: perfilController.titulo,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Descrição'),
                    ),
                    CustomTextField(
                      controller: perfilController.descricao,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text('Categoria'),
                    ),
                    CustomTextField(
                      controller: perfilController.categoria,
                      validatorText: 'Insira um texto válido',
                      hintText: '',
                      onChange: (value) {},
                    ),
                    CheckboxListTile(
                        value: perfilController.card,
                        title: Text('Aceita Cartão'),
                        onChanged: (value) {
                          setState(() {
                            perfilController.card = value;
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

                              db
                                  .collection('servico')
                                  .doc(perfilController.idServicoUser)
                                  .update({
                                    'nome': perfilController.titulo.text,
                                    'descricao':
                                        perfilController.descricao.text,
                                    'categoria':
                                        perfilController.categoria.text,
                                    'card': perfilController.card,
                                    'email': auth.currentUser.email
                                  })
                                  .then((value) {})
                                  .whenComplete(() {
                                    Modular.to.pop();
                                    Modular.to.popUntil(ModalRoute.withName(
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
