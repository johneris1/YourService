import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/main_navigation.controller.dart';
import 'package:yoursevice/views/pages/main.navigation.page.dart';

class MainNavigationModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MainNavigationController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, __) => MainNavigationPage()),
      ];
}
