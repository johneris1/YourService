import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/views/pages/cadastro.ofertante.page.dart';
import 'package:yoursevice/views/pages/cadastro.service.page.dart';
import 'package:yoursevice/views/pages/cadastro.solicitante.page.dart';
import 'package:yoursevice/views/pages/select.user.page.dart';

class SelectUserModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilController()),
      ];
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => SelectUserPage()),
        ModularRouter('/cadastro-solicitante',
            child: (_, args) => CadastroSolicitantePageOne()),
        ModularRouter('/cadastro-ofertante',
            child: (_, args) => CadastroOfertantePageOne()),
        ModularRouter('/cadastro-servico',
            child: (_, args) => CadastroServicoPageOne()),
      ];
  static Inject get to => Inject<SelectUserModule>.of();
}
