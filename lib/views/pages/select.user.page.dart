import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:yoursevice/Api/login.repository.dart';

class SelectUserPage extends StatefulWidget {
  @override
  _SelectUserPageState createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  var loginRepo = LoginRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  'YourService',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.blueAccent,
                  ),
                  child: FlatButton(
                      onPressed: () {
                        Modular.to
                            .pushNamed('/selec-user/cadastro-solicitante');
                      },
                      child: Text(
                        'Procurar Serviços',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.blueGrey[800],
                  ),
                  child: FlatButton(
                      onPressed: () {
                        print('ofertante');
                      },
                      child: Text(
                        'Ofertar Serviços',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
