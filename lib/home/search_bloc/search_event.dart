part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


class LoadSearchEvent extends SearchEvent{
  final String? category;
  final String? title;

  const LoadSearchEvent({ this.category,  this.title});
  @override
  List<Object> get props => [category!,title!];
}
