import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeControlsWidget extends StatelessWidget {
  final YoutubePlayerController controller;

  const YouTubeControlsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10),
          onPressed: () => controller.seekTo(
            controller.value.position - const Duration(seconds: 10),
          ),
        ),
        IconButton(
          icon: Icon(
            controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            controller.value.isPlaying
                ? controller.pause()
                : controller.play();
          },
        ),
        IconButton(
          icon: const Icon(Icons.forward_10),
          onPressed: () => controller.seekTo(
            controller.value.position + const Duration(seconds: 10),
          ),
        ),
      ],
    );
  }
}
