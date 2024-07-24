import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedTabCubit extends Cubit<int> {
  SelectedTabCubit() : super(0);

  void changeSelectedIndex(int selectedIndex) {
    emit(selectedIndex);
  }
}
