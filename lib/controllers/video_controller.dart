import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../utils/path_utils.dart';

class MyVideoController extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  int index = 0;

  List<String> allvideo = [
    "https://static.videezy.com/system/resources/previews/000/004/199/original/A_large_rock_waterfall.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://vod-progressive.akamaized.net/exp=1690619373~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2645%2F16%2F413229662%2F1776913801.mp4~hmac=6d6b6cb4f379e000f42ddea919e7cb7563f458a51070e15a4f8485302b6173d8/vimeo-prod-skyfire-std-us/01/2645/16/413229662/1776913801.mp4?filename=file.mp4",
    "https://vod-progressive.akamaized.net/exp=1690619531~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2535%2F15%2F387675206%2F1635261692.mp4~hmac=741e51455678eb13451e7acec75e93e53c8f4e5aaa6f42180571a7323c689b96/vimeo-prod-skyfire-std-us/01/2535/15/387675206/1635261692.mp4?filename=file.mp4",
    "https://vod-progressive.akamaized.net/exp=1690619906~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F2131%2F5%2F135655112%2F401490217.mp4~hmac=10883faa86ed2ba722e21bcad0c76c0107b13bfd4fe90df2e14094130131a28d/vimeo-prod-skyfire-std-us/01/2131/5/135655112/401490217.mp4?filename=file.mp4",
    "https://static.videezy.com/system/resources/previews/000/046/825/original/LAB_08-06-2019-197-in_effect.mp4",
  ];

  List<String> allname = [
    "Rock Waterfall",
    "Git hub demo",
    "Drone View Waterfall",
    "Night View",
    "Space Research Video",
    "Chemistry"
  ];

  MyVideoController() {
    init();
  }

  init() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        allvideo[index],
      ),
    )..initialize().then(
        (value) {
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: false,
            aspectRatio: videoPlayerController.value.aspectRatio,
          );
          notifyListeners();
        },
      );
  }

  changeIndex({required int ind}) {
    index = ind;
    init();
    notifyListeners();
  }
}
