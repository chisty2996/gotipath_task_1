import 'dart:developer';

import '../../../../core/resources/data_state.dart';
import '../../domain/repository/home_repository.dart';
import '../data_sources/remote/home_api_service.dart';
import '../models/home_model.dart';



class HomeRepositoryImpl implements HomeRepository{
  final HomeApiService _homeApiService;

  HomeRepositoryImpl(this._homeApiService);

  @override
  Future<DataState<List<HomeModel>>> getHomeItems(int pageNo) async{
    try{
      return await _homeApiService.getHomeItems(pageNo);

    }
    catch(e,s){
      log(e.toString());
      log(s.toString());
    }
    return const DataSuccess([]);
  }
}