import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../domain/entities/home.dart';
import '../../domain/usecases/get_home_item.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>  {
  final GetHomeItemUseCase getHomeItemUseCase;
  List<HomeEntity> previousItems = [];
  int currentPage = 1;

  HomeBloc({required this.getHomeItemUseCase}):super(const HomeStateLoading()){
    on<GetItems>(onGetItems);
    on<FilterItems>(onFilterItems);
    on<LoadMoreItems>(onLoadMoreItems);
  }

  void onGetItems(HomeEvent event, Emitter<HomeState> emit) async{
    // log("previous items: ${previousItems.length}");
    // if (previousItems.isNotEmpty) {
    //   emit(HomeStateFetched(previousItems)); // Emit previously fetched data
    //   return;
    // }
    // else{
    //
    // }
    currentPage = 1;
    final dataState = await getHomeItemUseCase(currentPage);
    List<HomeEntity> entities = dataState.data??[];
    if(dataState is DataSuccess && entities.isNotEmpty){
      previousItems = entities;
      emit( HomeStateFetched(entities));
    }

    else if(dataState is DataFailed){
      emit(HomeStateError(dataState.dioException));
    }
    else {
      emit(const HomeStateFetched([])); // Emit an empty list if there's no data
    }

  }

  void onLoadMoreItems(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeStateLoadingMore(previousItems));
    currentPage++;
    final dataState = await getHomeItemUseCase(currentPage);
    List<HomeEntity> newEntities = dataState.data ?? [];
    if (dataState is DataSuccess && newEntities.isNotEmpty) {
      previousItems.addAll(newEntities);
      emit(HomeStateFetched(previousItems));
    } else if (dataState is DataFailed) {
      emit(HomeStateError(dataState.dioException));
    } else {
      // No more data to load, keep the state as it is
      emit(HomeStateFetched(previousItems));
    }
  }

  void onFilterItems(FilterItems event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is HomeStateFetched || currentState is HomeStateFiltered) {
      final List<HomeEntity> items = (currentState is HomeStateFiltered)
          ? currentState.filteredItems
          : (currentState as HomeStateFetched).homeItems ?? [];
      final filteredItems = items
          .where((item) =>
          (item.currentDay??"").toString().contains(event.keyword.toLowerCase()))
          .toList();
      emit(HomeStateFiltered(filteredItems: filteredItems));
    }
    else{
      emit(const HomeStateFiltered(filteredItems: []));
    }
  }


}