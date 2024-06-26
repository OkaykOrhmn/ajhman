import 'package:ajhman/data/model/audio_player_model.dart';
import 'package:bloc/bloc.dart';


class AudioPlayerCubit extends Cubit<AudioPlayerModel> {
  AudioPlayerCubit() : super(AudioPlayerModel(volume: 1, pause: true, speed: 1));

  void reset(){
    emit(AudioPlayerModel(volume: 1, pause: true, speed: 1));
  }
  void setVolume(double v) {
    emit(state.copyWith(volume: v));
  }

  void setPause(bool pause) {
    emit(state.copyWith(pause: pause));
  }

  void changePause() {
    emit(state.copyWith(pause: !state.pause));
  }

  void changeSpeed(double speed) {
    emit(state.copyWith(speed: speed));
  }
}
