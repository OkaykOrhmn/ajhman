class AudioPlayerModel {
  bool pause = true;
  double speed = 1;
  double volume = 0;

  AudioPlayerModel(
      {required this.volume, required this.pause, required this.speed});

  AudioPlayerModel copyWith({ bool? pause, double? speed,double? volume}) {
    return AudioPlayerModel(
        volume: volume ?? this.volume,
        pause: pause ?? this.pause,
        speed: speed ?? this.speed);
  }
}
