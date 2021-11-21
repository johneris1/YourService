import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDio {
  Dio dio;

  CustomDio({this.dio});

  CustomDio.withAuthentication() {
    dio = Modular.get<Dio>();

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  Dio get instance => dio;

  _onRequest(RequestOptions options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('token');
    options.headers['authorization'] = 'Bearer $token';
    // client.options.headers['authorization'] =
    //     'Bearer ${_prefs.getString('token')}';
  }

  _onResponse(Response e) {
    print('############# Response Log');
    print(e.data);
    print('############# Response Log');
  }

  _onError(DioError e) {
    return e;
  }
}
