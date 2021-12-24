import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/Api/login.repository.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/views/widgets/loading.dialog.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var perfilController = Modular.get<PerfilController>();
  var loginRepo = LoginRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Text(
                    'Olá,' + auth.currentUser.displayName + '!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Container(
                    width: 320,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.blue,
                    ),
                    child: MaterialButton(
                      child: Text(
                        'Meu Perfil',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        LoadingDialog(context);
                        perfilController.getPerfil().whenComplete(() {
                          Modular.to.pop();
                          Modular.to.pushNamed('/user/perfil');
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 100,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.blue.shade900,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          loginRepo.logout(context);
                        },
                        child: Text(
                          'Logout ',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
                Visibility(
                  visible: perfilController.isOfffer == false ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: 100,
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.blue.shade900,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            Modular.to
                                .pushNamed('/selec-user/cadastro-ofertante');
                          },
                          child: Text(
                            'Quer ser um ofertante? Clique aqui',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ),
                Visibility(
                  visible: perfilController.isOfffer,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 100,
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.blue.shade900,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            perfilController.getServicosUser().whenComplete(() {
                              Modular.to.pushNamed('/user/my-servicos');
                            });
                          },
                          child: Text(
                            'Meus Serviços',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ),
                Visibility(
                  visible: perfilController.isOfffer,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: 100,
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.blue.shade900,
                      ),
                      child: FlatButton(
                          onPressed: () {
                            perfilController
                                .getPhone()
                                .then((value) {})
                                .whenComplete(() {
                              Modular.to
                                  .pushNamed('/selec-user/cadastro-servico');
                            });
                          },
                          child: Text(
                            'Ofertar Serviço',
                            style: TextStyle(fontSize: 20),
                          )),
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
