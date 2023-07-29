import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../utils/path_utils.dart';

class AudioController extends ChangeNotifier {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  Duration duration = Duration.zero;
  late int index;
  int j = 0;

  get position {
    return audioPlayer.currentPosition;
  }

  play() async {
    await audioPlayer.play();
    print("Play");
    notifyListeners();
  }

  open() {
    audioPlayer
        .open(
          Audio(
            auido + Songs.allsongs[index],
            metas: Metas(
              title: Songs.allsongs[index],
              image: MetasImage(
                type: ImageType.asset,
                path: images + Images.allimages[index],
              ),
            ),
          ),
          autoStart: false,
          showNotification: true,
        )
        .then(
          (value) => duration = audioPlayer.current.value!.audio.duration,
        );
    notifyListeners();
  }

  seek({required int second}) async {
    await audioPlayer.seek(
      Duration(
        seconds: second,
      ),
    );
    notifyListeners();
  }

  pageChange({required int index}) {
    j = index;
    notifyListeners();
  }

  time_manage({required int second}) {
    audioPlayer.seekBy(
      Duration(seconds: second),
    );
    notifyListeners();
  }

  take_index({required int ind}) {
    index = ind;
    notifyListeners();
  }

  pause() async {
    await audioPlayer.pause();
    notifyListeners();
  }
}
