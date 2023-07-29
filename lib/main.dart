import 'package:flutter/material.dart';
import 'package:my_media_player/controllers/audio_controller.dart';
import 'package:my_media_player/controllers/video_controller.dart';
import 'package:my_media_player/utils/routes_utils.dart';
import 'package:my_media_player/views/screens/audiopage.dart';
import 'package:my_media_player/views/screens/homepage.dart';
import 'package:my_media_player/views/screens/video.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AudioController()),
        ChangeNotifierProvider(create: (context) => MyVideoController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.home: (context) => const HomePage(),
        MyRoutes.video: (context) => const VideoPage(),
        MyRoutes.audio: (context) => const AudioPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
