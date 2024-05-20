

import '../../../../core/resources/data_state.dart';
import '../entities/home.dart';

abstract class HomeRepository{

  Future<DataState<List<HomeEntity>>> getHomeItems(int pageNo);
}