part of 'search_bloc.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<NewCourseCardModel> response;

  SearchSuccess({required this.response});
}

final class SearchFail extends SearchState {}

final class SearchEmpty extends SearchState {}
