import 'package:cpfcnpj/cpfcnpj.dart';

class InputValidators {
  static String nameIsValid(String name) => (name.isEmpty ||
          name.split(' ').length > 1 && name.split(' ')[1].isEmpty ||
          name.split(' ').length < 2)
      ? 'Digite seu nome e sobrenome.'
      : null;
  static String nameCompletIsValid(String name) => (name.isEmpty ||
          name.split(' ').length > 1 && name.split(' ')[1].isEmpty ||
          name.split(' ').length < 2)
      ? 'Digite seu nome completo.'
      : null;
  static String razaoSocialIsValid(String razao) => (razao.isEmpty ||
          razao.split(' ').length > 1 && razao.split(' ')[1].isEmpty ||
          razao.split(' ').length < 2)
      ? 'Digite uma Razão Social Válida.'
      : null;
  static String nomeFantlIsValid(String fant) => (fant.isEmpty ||
          fant.split(' ').length > 1 && fant.split(' ')[1].isEmpty ||
          fant.split(' ').length < 2)
      ? 'Digite um Nome Fantasia Válido.'
          'Please enter a valid business name.'
      : null;
  static String passwordIsValid(String _password) => (_password.isEmpty)
      ? 'Digite sua senha.'
      : (_password.length < 6)
          ? 'Mínimo de seis caracteres.'
          : null;

  static String confirmIsValid(String _confirm, String _password) =>
      (_confirm.isEmpty)
          ? 'Confirme sua senha.'
          : (_confirm != _password)
              ? 'As senhas precisam ser idênticas.'
              : null;

  static String emailIsValid(String _email) {
    final _test =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final _isValid = RegExp(_test).hasMatch(_email);

    return (_email.isEmpty || !_isValid) ? 'Digite um email válido.' : null;
  }

  static String nameUserIsValid(String _nameUser) => (_nameUser.isEmpty)
      ? 'Digite seu nome de usuário.'
      : (_nameUser.length < 6)
          ? 'Minimo de 6 caracteres.'
          : null;
  static String faceIsValid(String _face) =>
      (_face.isEmpty) ? 'Digite seu Facebook.' : null;
  static String instagramIsValid(String _insta) =>
      (_insta.isEmpty) ? 'Digite seu Facebook.' : null;
  static String twitterIsValid(String _tw) =>
      (_tw.isEmpty) ? 'Digite seu Facebook.' : null;
  static String linkeIsValid(String _linke) =>
      (_linke.isEmpty) ? 'Digite seu Facebook.' : null;
  static String dateIsValid(String _date) => (_date.isEmpty)
      ? 'Digite sua Data de Nascimento.'
      : (_date.length < 10)
          ? 'Digite uma data válida.'
          : null;
  static String dateIIsValid(String _date) => (_date.isEmpty)
      ? 'Digite a data de realização do serviço.'
      : (_date.length < 10)
          ? 'Digite uma data válida.'
          : null;
  static String cpfIsValid(String _cpf) =>
      !CPF.isValid(_cpf) ? 'CPF inválido.' : null;

  static String cnpjIsValid(String _cnpj) =>
      !CNPJ.isValid(_cnpj) ? 'CNPJ Inválido.' : null;

  static String phoneIsValid(String _phone) {
    final _tel = _phone.replaceAll(new RegExp(r'[^\w\s]+'), '');

    return (_tel.isEmpty)
        ? 'Digite seu telefone.'
        : (_tel.length < 11 || _tel.length > 12)
            ? 'Telefone inválido.'
            : null;
  }

  static String wppIsValid(String _wpp) {
    final _tel = _wpp.replaceAll(new RegExp(r'[^\w\s]+'), '');

    return (_tel.isEmpty)
        ? 'Digite seu WhatsApp.'
        : (_tel.length != 12)
            ? 'WhatsApp inválido.'
            : null;
  }

  static String numberValid(String _number) =>
      (_number.isEmpty) ? 'Digite o número da casa ou s/n para vazio' : null;

  static String cepIsValid(String _cep) => (_cep.isEmpty)
      ? 'Digite seu Cep.'
      : (_cep.length < 10)
          ? 'Cep Inválido.'
          : null;
  static String tituValid(String _titu) =>
      (_titu.isEmpty) ? 'Digite o titulo do serviço.' : null;
  static String descValid(String _desc) =>
      (_desc.isEmpty) ? 'Digite a descrição do serviço.' : null;
  static String precoValid(String _prec) =>
      (_prec.isEmpty) ? 'Digite o preço do serviço.' : null;
}
