import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/open.service.controller.dart';
import 'package:yoursevice/controller/perfil.controller.dart';

class BuscaPage extends StatefulWidget {
  const BuscaPage({Key key}) : super(key: key);

  @override
  _BuscaPageState createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscaPage> {
  var perfilController = Modular.get<PerfilController>();
  var openServiceController = Modular.get<OpenServiceController>();
  Timer timer;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(Duration(seconds: 10), (Timer timer) {
      setState(() {
        isLoading = true;
        print('load init');
        perfilController.getServicosUserGeral().whenComplete(() {
          setState(() {
            isLoading = false;
            print('load f');
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Todos os Serviços')),
        leading: Container(),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: perfilController.servicosUserGeral.length,
        itemBuilder: (BuildContext context, int index) {
          return isLoading == false
              ? InkWell(
                  onTap: () {
                    openServiceController.titulo =
                        perfilController.servicosUserGeral[index].nome;
                    openServiceController.credito =
                        perfilController.servicosUserGeral[index].isCard;
                    openServiceController.categoria =
                        perfilController.servicosUserGeral[index].categoria;
                    openServiceController.desc =
                        perfilController.servicosUserGeral[index].desc;
                    openServiceController.email =
                        perfilController.servicosUserGeral[index].email;
                    openServiceController.telefone =
                        perfilController.servicosUserGeral[index].telefone;

                    Modular.to.pushNamed('/busca/open');
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 60, left: 60),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        perfilController
                                            .servicosUserGeral[index].nome,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(perfilController
                                .servicosUserGeral[index].categoria),
                          ],
                        ),
                      ),
                      height: 120,
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
