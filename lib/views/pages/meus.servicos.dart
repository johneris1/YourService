import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/open.service.controller.dart';
import 'package:yoursevice/controller/perfil.controller.dart';

class MyServicos extends StatefulWidget {
  const MyServicos({Key key}) : super(key: key);

  @override
  _MyServicosState createState() => _MyServicosState();
}

class _MyServicosState extends State<MyServicos> {
  var perfilController = Modular.get<PerfilController>();
  var openServiceController = Modular.get<OpenServiceController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Serviços'),
        leading: Container(),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: perfilController.servicosUser.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 60, left: 60),
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
                                  perfilController.servicosUser[index].nome,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(perfilController.servicosUser[index].categoria),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              perfilController
                                  .deletMyService(
                                      perfilController.servicosUser[index].id,
                                      context)
                                  .whenComplete(() {});
                            },
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Icon(
                                  Icons.delete_forever,
                                  size: 30,
                                )),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          InkWell(
                            onTap: () {
                              perfilController.titulo.text =
                                  perfilController.servicosUser[index].nome;
                              perfilController.card =
                                  perfilController.servicosUser[index].isCard;
                              perfilController.categoria.text = perfilController
                                  .servicosUser[index].categoria;
                              perfilController.idServicoUser =
                                  perfilController.servicosUser[index].id;
                              perfilController.descricao.text =
                                  perfilController.servicosUser[index].desc;

                              Modular.to.pushNamed('/user/edit');
                            },
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.edit_road_sharp,
                                  size: 30,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                height: 120,
              ),
            ),
          );
        },
      ),
    );
  }
}
