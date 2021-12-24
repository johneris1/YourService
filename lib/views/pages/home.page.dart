import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var perfilController = Modular.get<PerfilController>();
  Timer timer;
  @override
  void initState() {
    super.initState();
    // timer = new Timer.periodic(Duration(seconds: 3), (Timer timer) {
    //   setState(() {
    //     perfilController.getServicosUserGeral();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
              'https://www.iset.com.br/blog/wp-content/webp-express/webp-images/uploads/2017/08/114213-entregar-revisao-ate-1108-16h-ecommerce-como-incluilo-na-minha-oferta-de-servicos-digitais.jpg.webp'),
          Center(
            child: Text(
              'Oferte um serviço e Divulgue nossa plataforma :) ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
