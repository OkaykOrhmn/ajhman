part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitialState
    extends CategoryState {}
final class CategoryLoadingState extends CategoryState {}
final class CategorySuccessState extends CategoryState {
  final List<NewCourseCardModel> newsCards;

  CategorySuccessState({required this.newsCards});
}
final class CategoryFailState extends CategoryState {}
