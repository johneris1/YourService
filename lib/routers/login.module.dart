import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/views/pages/Login.page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilController()),
      ];
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LoginPage()),
      ];
  static Inject get to => Inject<LoginModule>.of();
}
