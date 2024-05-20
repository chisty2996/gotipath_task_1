

import '../../../../core/resources/data_state.dart';
import '../entities/home.dart';
import '../repository/home_repository.dart';

class GetHomeItemUseCase{
  final HomeRepository homeRepository;

  GetHomeItemUseCase({required this.homeRepository});

  Future<DataState<List<HomeEntity>>> call(int pageNo){
    return homeRepository.getHomeItems(pageNo);
  }
}