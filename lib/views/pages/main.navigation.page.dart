import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:yoursevice/controller/main_navigation.controller.dart';
import 'package:yoursevice/controller/perfil.controller.dart';
import 'package:yoursevice/routers/busca.module.dart';
import 'package:yoursevice/routers/home.module.dart';
import 'package:yoursevice/routers/user.module.dart';
import 'package:yoursevice/views/widgets/button,navigation.widget.dart';

class MainNavigationPage extends StatefulWidget {
  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  final mainNavController = Modular.get<MainNavigationController>();
  var perfilController = Modular.get<PerfilController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: mainNavController.pageViewController,
        children: [
          RouterOutlet(module: HomeModule()),
          RouterOutlet(module: UserModule()),
          Container(
            child: Center(child: Text('sobre')),
          ),
          RouterOutlet(module: BuscaModule()),
          // RouterOutlet(module: QuizModule()),
          // RouterOutlet(module: AjudaModule()),
          // RouterOutlet(module: BuscarModule()),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 10)
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: AnimatedBuilder(
              animation: mainNavController.pageViewController,
              builder: (context, snapshot) {
                return Theme(
                    data: ThemeData(
                      brightness: Brightness.light,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                        backgroundColor: Colors.white,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: mainNavController.currentPage,
                        onTap: (index) {
                          mainNavController.pageViewController
                              .jumpToPage(index);
                          print(index);
                          if (index == 3) {
                            setState(() {
                              perfilController.getServicosUserGeral();
                            });
                          }
                        },
                        items: [
                          customNavItemStatic(
                              iconColor:
                                  mainNavController.setIconColor(position: 0),
                              iconPath: ImagesPath.iconBottomHome,
                              label: 'home'),
                          customBottomNavItem(
                              iconColor:
                                  mainNavController.setIconColor(position: 1),
                              iconPath: ImagesPath.iconBottomUser,
                              label: 'perfil',
                              marginRight: 0),
                          customBottomNavItem(
                            iconColor:
                                mainNavController.setIconColor(position: 2),
                            iconPath: ImagesPath.iconBottomAjuda,
                            label: 'ajuda',
                            marginLeft: 0,
                          ),
                          customNavItemStatic(
                              iconColor:
                                  mainNavController.setIconColor(position: 3),
                              iconPath: ImagesPath.iconBottomPesquisa,
                              label: 'buscar')
                        ]));
              }),
        ),
      ),
    );
  }
}
