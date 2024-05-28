import 'package:ajhman/core/utils/app_locale.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'selected_index_state.dart';

class SelectedIndexCubit extends Cubit<SelectedIndexState> {
  SelectedIndexCubit() : super(SelectedIndexState());

  void changeSelectedIndex(int selectedIndex, String? title){
    emit(state.copyWith(selectedIndex: selectedIndex, title: title));
  }
}
