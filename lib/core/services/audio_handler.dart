import 'dart:async';

import 'package:audio_wave/audio_wave.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioHandler {
  late AudioPlayer _player;
  PlayerState? _playerState;
  Duration? audioDuration = Duration.zero;
  Duration? audioPosition = Duration.zero;
  bool isLoading = true;

  StreamSubscription? durationSubscriptionS;
  StreamSubscription? positionSubscriptionS;
  StreamSubscription? playerCompleteSubscriptionS;
  StreamSubscription? playerStateChangeSubscriptionS;

  AudioPlayer get player => _player;

  PlayerState? get playerState => _playerState;

  bool get isPlaying => _playerState == PlayerState.playing;

  bool get isPaused => _playerState == PlayerState.paused;

  String get durationText => audioDuration?.toString().split('.').first ?? '';

  String get positionText => audioPosition?.toString().split('.').first ?? '';

  AudioHandler(String url) {
    _player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    _player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    // WidgetsBinding.instance.addPostFrameCallback((_) async {

    _player
        // .play(UrlSource(
        //     'https://bedunim.ir/wp-content/uploads/2024/06/02.Mehrad-Hidden-Shayea-Romania-320.mp3'))
        .play(UrlSource(url))
        .then((value) {
      _player.pause();
      isLoading = false;
      _playerState = PlayerState.paused;
    });

    // });

    player.getDuration().then((value) => audioDuration = value);

    player.getCurrentPosition().then((value) => audioPosition = value);
  }

  StreamSubscription? durationSubscription(Function(Duration d) func) {
    return durationSubscriptionS = player.onDurationChanged.listen((duration) {
      // setState(() => _duration = duration);
      audioDuration = duration;
      func(duration);
    });
  }

  StreamSubscription? positionSubscription(Function(Duration d) func) {
    return positionSubscriptionS = player.onPositionChanged.listen(
      (p) {
        audioPosition = p;
        func(p);
      },
    );
  }

  StreamSubscription? playerCompleteSubscription(Function() func) {
    return playerCompleteSubscriptionS =
        player.onPlayerComplete.listen((event) {
      stop();
      func();
    });
  }

  StreamSubscription? playerStateChangeSubscription(
      Function(PlayerState) func) {
    return playerStateChangeSubscriptionS =
        player.onPlayerStateChanged.listen((state) {
      _playerState = state;
      func(state);
    });
  }

  Future<void> play() async {
    await _player.resume();
    // _playerState = PlayerState.playing;
  }

  Future<void> pause() async {
    await _player.pause();
    // _playerState = PlayerState.paused;
  }

  Future<void> stop() async {
    await _player.stop();
    // _playerState = PlayerState.stopped;
    audioPosition = Duration.zero;
  }

// void _initStreams() {
//   durationSubscription = player.onDurationChanged.listen((duration) {
//     setState(() => _duration = duration);
//   });
//
//   _positionSubscription = player.onPositionChanged.listen(
//     (p) {
//       setState(() {
//         _position = p;
//         for (var i = 0; i < bars.length / 10; i++) {
//           if (i <= _position!.inSeconds) {
//             bars[i].color = primaryColor;
//           }
//         }
//       });
//     },
//   );
//
//   _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
//     setState(() {
//       _playerState = PlayerState.stopped;
//       _position = Duration.zero;
//     });
//   });
//
//   _playerCompleteSubscription = player.onSeekComplete.listen((event) {
//     setState(() {
//       print(
//           "Complete------------------------------------------------------------");
//     });
//   });
//
//   _playerStateChangeSubscription =
//       player.onPlayerStateChanged.listen((state) {
//     setState(() {
//       _playerState = state;
//     });
//   });
// }
}
