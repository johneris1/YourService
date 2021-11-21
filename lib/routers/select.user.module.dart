import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/views/pages/select.user.page.dart';

class SelectUserModule extends ChildModule {
  @override
  List<Bind> get binds => [];
  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => SelectUserPage()),
      ];
  static Inject get to => Inject<SelectUserModule>.of();
}
