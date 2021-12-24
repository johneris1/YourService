import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/views/pages/busca.page.dart';
import 'package:yoursevice/views/pages/open.service.page.dart';

class BuscaModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, __) => BuscaPage()),
        ModularRouter('/open', child: (_, args) => OpenService())
      ];
}
