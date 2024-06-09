import 'package:ajhman/data/model/video_player_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerModel> {
  VideoPlayerCubit()
      : super(VideoPlayerModel(
            mute: true,
            pause: true,
            fullScreen: false,
            showControls: false,
            speed: 1));

  void changeMute() {
    emit(state.copyWith(mute: !state.mute));
  }

  void setPause(bool pause) {
    emit(state.copyWith(pause: pause));
  }

  void changePause() {
    emit(state.copyWith(pause: !state.pause));
  }

  void changeFullScreen() {
    emit(state.copyWith(fullScreen: !state.fullScreen));
  }

  void changeShowControls() {
    emit(state.copyWith(showControls: !state.showControls));
  }

  void setShowControls(bool showControls) {
    emit(state.copyWith(showControls: showControls));
  }

  void changeSpeed(double speed) {
    emit(state.copyWith(speed: speed));
  }
}
