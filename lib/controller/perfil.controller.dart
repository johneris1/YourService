import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:yoursevice/views/widgets/loading.dialog.dart';

part 'perfil.controller.g.dart';

class PerfilController = _PerfilControllerBase with _$PerfilController;

abstract class _PerfilControllerBase with Store {
  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final cep = TextEditingController();
  final telefone = TextEditingController();
  final nomeUser = TextEditingController();
  final cpf = TextEditingController();
  final titulo = TextEditingController();
  final descricao = TextEditingController();
  final categoria = TextEditingController();
  final phone = TextEditingController();
  var idServicoUser;
  bool card;
  List<ServicoUser> servicosUser = [];
  int servico;
  var id;
  var isOfffer;
  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;

  List<ServicoUserGeral> servicosUserGeral = [];

  Future<void> getPerfil() async {
    QuerySnapshot resultado = await db.collection('usuario').get();

    resultado.docs.forEach((element) {
      var list = element.data();
      if (list['email'] == auth.currentUser.email) {
        id = element.id;
        print('id: ${element.id}');
        telefone.text = list['telefone'];
        dataNascimento.text = list['data_nascimento'];
        nome.text = list['nome'];
        cep.text = list['cep'];
        cpf.text = list['cpf'];
        nomeUser.text = auth.currentUser.displayName;
      }
    });
  }

  Future<void> getPhone() async {
    QuerySnapshot resultado = await db.collection('usuario').get();

    resultado.docs.forEach((element) {
      var list = element.data();
      if (list['email'] == auth.currentUser.email) {
        id = element.id;

        phone.text = list['telefone'];
      }
    });
  }

  Future<void> getServicosUser() async {
    QuerySnapshot resultado = await db.collection('servico').get();
    servicosUser.clear();

    resultado.docs.forEach((element) {
      print(element.data());
      var list = element.data();
      if (list['email'] == auth.currentUser.email) {
        print('id: ${element.id}');
        servicosUser.add(ServicoUser(
          id: element.id,
          isCard: list['card'],
          nome: list['nome'],
          categoria: list['categoria'],
          desc: list['descricao'],
        ));

        nomeUser.text = auth.currentUser.displayName;
      }
    });
  }

  Future<void> updatePerfil() async {
    auth.currentUser.updateProfile(displayName: nomeUser.text).whenComplete(() {
      print(auth.currentUser.displayName);
      db
          .collection('usuario')
          .doc(id)
          .update({
            'isOfertante': false,
            'nome': nome.text,
            'data_nascimento': dataNascimento.text,
            'email': auth.currentUser.email,
            'cep': cep.text,
            'telefone': telefone.text,
          })
          .then((value) {})
          .whenComplete(() {
            Modular.to.pop();
            Modular.to.popUntil(ModalRoute.withName('/main-navigation'));
          });
    });
  }

  Future<void> updatePerfilOffert() async {
    auth.currentUser.updateProfile(displayName: nomeUser.text).whenComplete(() {
      print(auth.currentUser.displayName);
      db
          .collection('usuario')
          .doc(id)
          .update({
            'isOfertante': true,
            'nome': nome.text,
            'data_nascimento': dataNascimento.text,
            'email': auth.currentUser.email,
            'cep': cep.text,
            'telefone': telefone.text,
            'cpf': cpf.text
          })
          .then((value) {})
          .whenComplete(() {
            Modular.to.pop();
            Modular.to.popUntil(ModalRoute.withName('/main-navigation'));
          });
    });
  }

  Future<void> deletSolicitante() async {
    auth.currentUser.delete();
    db.collection('usuario').doc(id).delete();
    Modular.to.popUntil(ModalRoute.withName('/'));
  }

  Future<void> deletIsBank() async {
    db.collection('usuario').doc(id).delete();
  }

  Future<void> deletMyService(var ids, BuildContext context) async {
    LoadingDialog(context);
    db
        .collection('servico')
        .doc(ids)
        .delete()
        .then((value) {})
        .whenComplete(() {
      getServicosUser().whenComplete(() {
        Modular.to.popUntil(ModalRoute.withName('/main-navigation'));
        Modular.to.pushNamed('/user/my-servicos');
      });
    });
  }

  Future<void> getInfo() async {
    QuerySnapshot resultado = await db.collection('usuario').get();

    resultado.docs.forEach((element) {
      var list = element.data();
      if (list['email'] == auth.currentUser.email) {
        print(element.data());
        id = element.id;
        print('id: ${element.id}');
        isOfffer = list['isOfertante'];
        print(isOfffer);
      }
    });
  }

  Future<void> getServicosUserGeral() async {
    QuerySnapshot resultado = await db.collection('servico').get();
    servicosUserGeral.clear();

    resultado.docs.forEach((element) {
      print(element.data());
      var list = element.data();

      print('id: ${element.id}');
      servicosUserGeral.add(ServicoUserGeral(
        id: element.id,
        isCard: list['card'],
        nome: list['nome'],
        categoria: list['categoria'],
        desc: list['descricao'],
        email: list['email'],
        telefone: list['telefone'],
      ));
    });
  }
}

class ServicoUser {
  var id;
  String nome;
  String categoria;
  bool isCard;
  String desc;

  ServicoUser({this.id, this.nome, this.isCard, this.categoria, this.desc});
}

class ServicoUserGeral {
  var id;
  String nome;
  String categoria;
  bool isCard;
  String desc;
  String email;
  String telefone;

  ServicoUserGeral(
      {this.id,
      this.nome,
      this.isCard,
      this.categoria,
      this.desc,
      this.email,
      this.telefone});
}
