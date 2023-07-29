import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/audio_controller.dart';
import '../../utils/path_utils.dart';
import '../../utils/routes_utils.dart';

class Audio extends StatefulWidget {
  const Audio({super.key});

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  int i = 0;

  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  SliderComponentShape? thumb = SliderComponentShape.noThumb;
  int select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AudioController>(builder: (context, pro, _) {
        return Stack(
          children: [
            Image.network(
              "https://media.tenor.com/Q2XfXTVZDd8AAAAC/windows-xp-music.gif",
              fit: BoxFit.fill,
              height: double.infinity,
            ),
            StreamBuilder(
              stream: Provider.of<AudioController>(context).position,
              builder: (BuildContext context,
                      AsyncSnapshot<Duration> snapshot) =>
                  (snapshot.hasData)
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CarouselSlider(
                                items: [
                                  Image.asset(images + Images.allimages[0]),
                                  Image.asset(images + Images.allimages[1]),
                                  Image.asset(images + Images.allimages[2]),
                                  Image.asset(images + Images.allimages[3]),
                                ],
                                options: CarouselOptions(
                                  onPageChanged: (index, res) {
                                    pro.pageChange(index: index);
                                  },
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (pro.j == 0)
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (pro.j == 1)
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (pro.j == 2)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (pro.j == 3)
                                            ? Colors.red
                                            : Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: Songs.allsongs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => Card(
                                    color: Colors.grey,
                                    child: ListTile(
                                      onTap: () {
                                        pro.take_index(ind: index);
                                        pro.open();
                                        Navigator.of(context).pushNamed(
                                          MyRoutes.audio,
                                          arguments: index,
                                        );
                                        pro.play();
                                        select = index;
                                      },
                                      leading: Text(
                                        "${index + 1}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      title: Text(
                                        Songs.allsongs[index],
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const CircularProgressIndicator(),
            ),
          ],
        );
      }),
      bottomSheet: SizedBox(
        height: 80,
        child: StreamBuilder(
          stream: Provider.of<AudioController>(context).position,
          builder: (BuildContext context, AsyncSnapshot snapshot) => (snapshot
                  .hasData)
              ? Container(
                  color: Colors.grey,
                  child: Consumer<AudioController>(builder: (context, pro, _) {
                    return Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            images + Images.allimages[select],
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderThemeData(thumbShape: thumb),
                            child: Slider(
                              onChanged: (val) {
                                pro.seek(
                                  second: val.toInt(),
                                );
                              },
                              value: snapshot.data!.inSeconds.toDouble(),
                              min: 0,
                              max: pro.duration.inSeconds.toDouble(),
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
                      ],
                    );
                  }),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
