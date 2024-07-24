import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/language.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }
}
