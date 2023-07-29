import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/audio_controller.dart';
import '../../utils/path_utils.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  int i = 0;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  SliderComponentShape? thumb = SliderComponentShape.noThumb;

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return StreamBuilder(
      stream: Provider.of<AudioController>(context).position,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          (snapshot.hasData)
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        Songs.allsongs[index],
                      ),
                      centerTitle: true,
                    ),
                    body: Consumer<AudioController>(
                      builder: (_, pro, __) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            images + Images.allimages[index],
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                              thumbShape: thumb,
                            ),
                            child: Slider(
                              min: 0,
                              max: pro.duration.inSeconds.toDouble(),
                              value: snapshot.data!.inSeconds.toDouble(),
                              onChanged: (val) {
                                pro.seek(
                                  second: val.toInt(),
                                );
                              },
                              onChangeStart: (val) {
                                setState(
                                  () {
                                    thumb = null;
                                  },
                                );
                              },
                              onChangeEnd: (val) {
                                thumb = SliderComponentShape.noOverlay;
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${pro.audioPlayer.currentPosition.value.inMinutes} : ${pro.audioPlayer.currentPosition.value.inSeconds % 60}",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  pro.time_manage(second: -20);
                                },
                                icon: const Icon(Icons.arrow_back_ios_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (i % 2 == 0) {
                                    pro.play();
                                    controller.forward();
                                    i++;
                                  } else {
                                    pro.pause();
                                    controller.reverse();
                                    i++;
                                  }
                                },
                                icon: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  progress: controller,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  pro.time_manage(second: 20);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const CircularProgressIndicator(),
    );
  }
}
