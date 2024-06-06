part of 'selected_index_cubit.dart';

@immutable
class SelectedIndexState extends Equatable {
  int index;
  String title;

  SelectedIndexState({this.index = 0, this.title = 'خانه'});

  SelectedIndexState copyWith({int? selectedIndex, String? title}) =>
      SelectedIndexState(index: selectedIndex!, title: title!);

  @override
  List<Object> get props => [index];
}
