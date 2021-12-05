import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'perfil.controller.g.dart';

class PerfilController = _PerfilControllerBase with _$PerfilController;

abstract class _PerfilControllerBase with Store {
  final nome = TextEditingController();
  final dataNascimento = TextEditingController();
  final cep = TextEditingController();
  final telefone = TextEditingController();
  final nomeUser = TextEditingController();
  var id;
  FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  Future<void> getPerfilSolicitante() async {
    QuerySnapshot resultado = await db.collection('solicitante').get();
    resultado.docs.forEach((element) {
      id = element.id;
      print('id: ${element.id}');
      var list = element.data();
      telefone.text = list['telefone'];
      dataNascimento.text = list['data_nascimento'];
      nome.text = list['nome'];
      cep.text = list['cep'];
      nomeUser.text = auth.currentUser.displayName;
    });
  }

  Future<void> updatePerfil() async {
    auth.currentUser.updateProfile(displayName: nomeUser.text).whenComplete(() {
      print(auth.currentUser.displayName);
      db
          .collection('solicitante')
          .doc(id)
          .update({
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

  Future<void> deletSolicitante() async {
    auth.currentUser.delete();
    db.collection('solicitante').doc(id).delete();
    Modular.to.popUntil(ModalRoute.withName('/'));
  }
}
