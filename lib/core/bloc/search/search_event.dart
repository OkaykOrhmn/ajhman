part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class GetAllSearch extends SearchEvent {
  final String? type;
  final String search;

  GetAllSearch({required this.type, required this.search});
}

class ClearAllSearch extends SearchEvent {}
class TypingSearch extends SearchEvent {}
