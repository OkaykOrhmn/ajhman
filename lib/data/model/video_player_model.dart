class VideoPlayerModel {
  bool mute = true;
  bool pause = true;
  bool fullScreen = false;
  bool showControls = false;
  double speed = 1;

  VideoPlayerModel(
      {
      required this.mute,
      required this.pause,
      required this.fullScreen,
      required this.showControls,
      required this.speed});

  VideoPlayerModel copyWith(
      {
      bool? mute,
      bool? pause,
      bool? fullScreen,
      bool? showControls,
        double? speed}) {
    return VideoPlayerModel(
        mute: mute ?? this.mute,
        pause: pause ?? this.pause,
        fullScreen: fullScreen ?? this.fullScreen,
        showControls: showControls ?? this.showControls,
        speed: speed ?? this.speed);
  }
}
