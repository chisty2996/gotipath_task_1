abstract class HomeEvent{
  const HomeEvent();
}

class GetItems extends HomeEvent{
  const GetItems();
}

class FilterItems extends HomeEvent {
  final String keyword;

  const FilterItems(this.keyword);
}

class LoadMoreItems extends HomeEvent {
  const LoadMoreItems();
}

