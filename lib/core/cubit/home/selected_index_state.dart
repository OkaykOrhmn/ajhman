// ignore_for_file: must_be_immutable
part of 'selected_index_cubit.dart';

class SelectedIndexState extends Equatable {
  int index;
  String title;

  SelectedIndexState({this.index = 0, this.title = 'خانه'});

  SelectedIndexState copyWith({int? selectedIndex, String? title}) =>
      SelectedIndexState(index: selectedIndex!, title: title!);

  @override
  List<Object> get props => [index];
}
