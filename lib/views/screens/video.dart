import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/video_controller.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    // pro.init();
    return Scaffold(
      body: Consumer<MyVideoController>(builder: (context, pro, _) {
        return Stack(
          children: [
            Image.network(
              "https://media.tenor.com/Q2XfXTVZDd8AAAAC/windows-xp-music.gif",
              fit: BoxFit.fill,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  (pro.videoPlayerController.value.isInitialized)
                      ? AspectRatio(
                          aspectRatio:
                              pro.videoPlayerController.value.aspectRatio,
                          child: Chewie(
                            controller: pro.chewieController,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: pro.allvideo.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.grey,
                        child: ListTile(
                          title: Text(pro.allname[index]),
                          leading: Text("${index + 1}"),
                          onTap: () {
                            pro.changeIndex(ind: index);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
