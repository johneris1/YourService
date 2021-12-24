import 'package:mobx/mobx.dart';
part 'open.service.controller.g.dart';

class OpenServiceController = _OpenServiceControllerBase
    with _$OpenServiceController;

abstract class _OpenServiceControllerBase with Store {
  String titulo;
  String telefone;
  String desc;
  String email;
  String categoria;
  bool credito;
}
