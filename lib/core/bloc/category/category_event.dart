part of 'category_bloc.dart';

sealed class CategoryEvent {}

class GetAllCategoryCards extends CategoryEvent {
  final List<int> categories;
  final Tags tag;
  GetAllCategoryCards({required this.categories, required this.tag});
}
