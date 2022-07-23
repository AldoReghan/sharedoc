import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String link;
  const VideoPlayer({Key? key, required this.link}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String url = widget.link;

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags:
            const YoutubePlayerFlags(mute: false, loop: false, autoPlay: true));
  }

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
      player: YoutubePlayer(controller: controller!),
      builder: (context, player) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [player],
            ),
          ));
}
