
import 'package:dio/dio.dart';

import '../constants/constants.dart';

class NetworkClient {
  final Dio _dio;

  NetworkClient(this._dio){
    dio.options = BaseOptions(baseUrl: Constants.apiBaseUrl);
  }

  get dio => _dio;

}
