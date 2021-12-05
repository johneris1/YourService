import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/views/pages/perfil.solicitante.page.dart';
import 'package:yoursevice/views/pages/user.page.dart';

class UserModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilController()),
      ];
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => UserPage()),
        ModularRouter('/perfil', child: (_, args) => PerfilPageOne()),
      ];
  static Inject get to => Inject<UserModule>.of();
}
