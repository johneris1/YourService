import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/routers/cadastro.module.dart';
import 'package:yoursevice/routers/login.module.dart';
import 'package:yoursevice/routers/main.navigation.module.dart';
import 'package:yoursevice/routers/select.user.module.dart';
import 'package:yoursevice/routers/user.module.dart';
import 'package:yoursevice/shared/custom.dio.dart';
import 'package:yoursevice/views/pages/boas.vindas.page.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        theme: ThemeData(
          fontFamily: 'Montserrat',
        ),
        initialRoute: "/",
        title: 'YourService',
        navigatorKey: Modular.navigatorKey,
        onGenerateRoute: Modular.generateRoute,
      );
}

// app_module.dart
class AppModule extends MainModule {
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => BoasVindasPage()),
        ModularRouter('/cadastro', module: CadastroModule()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/user', module: UserModule()),
        ModularRouter('/selec-user', module: SelectUserModule()),
        ModularRouter('/main-navigation', module: MainNavigationModule()),
      ];
  List<Bind> get binds => [
        Bind((i) => CustomDio()),
      ];
  @override
  Widget get bootstrap => AppWidget();
}
