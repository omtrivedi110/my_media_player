import 'package:flutter/material.dart';
import 'package:my_media_player/views/screens/video.dart';

import '../../utils/path_utils.dart';
import 'audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Player"),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              text: "Videos",
            ),
            Tab(
              text: "Audio",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          //video page()
          VideoPage(),
          // AudioPage(),
          Audio(),
        ],
      ),
    );
  }
}
