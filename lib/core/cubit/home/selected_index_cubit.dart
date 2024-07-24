import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'selected_index_state.dart';

class SelectedIndexCubit extends Cubit<SelectedIndexState> {
  SelectedIndexCubit() : super(SelectedIndexState());

  void changeSelectedIndex(int selectedIndex, String? title) {
    emit(state.copyWith(selectedIndex: selectedIndex, title: title));
  }
}
