import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../../../../core/resources/data_state.dart';
import '../../models/home_model.dart';

class HomeApiService {
  final Dio dio;

  HomeApiService({
    required this.dio,
  });

  Future<DataState<List<HomeModel>>> getHomeItems(int pageNo) async {
    try {
      final response = await dio.get('/v1/calendar/2017/4?latitude=51.508515&longitude=-0.1254872&method=2');
      log("api response: $response");
      log("api response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<HomeModel> items = List<Map<String, dynamic>>.from(response.data["data"])
            .map((e) => HomeModel.fromJson(e))
            .toList();
        return DataSuccess(items);
      }
      else{
        return DataFailed(DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: "Unexpected status code: ${response.statusCode}",
        ));
      }
    } on DioException catch (e,s) {
      log(s.toString());
      return DataFailed(e);
    }
    catch(e,s){
      log(s.toString());
      return DataFailed(DioException(
        requestOptions: RequestOptions(path: '/search/repositories'),
        type: DioExceptionType.unknown,
        error: e.toString(),
      ));
    }
    return DataFailed(DioException(requestOptions: RequestOptions()));
  }
}
