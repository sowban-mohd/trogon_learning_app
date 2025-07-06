import 'package:flutter/material.dart';
import 'package:trogan_learning_app/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_vimeo/flutter_vimeo.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    //Extracting video id to use in player controller
    if (widget.video.videoType == 'YouTube') {
      String extractYouTubeVideoId(String url) {
        final uri = Uri.parse(url);
        return uri.queryParameters['v'] ?? '';
      }

      _youtubeController = YoutubePlayerController(
        initialVideoId: extractYouTubeVideoId(widget.video.url),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  //Extracting vimeo video id to use in player controller
  String extractVimeoId(String url) {
    final regex = RegExp(r'vimeo\.com/(?:video/)?(\d+)');
    final match = regex.firstMatch(url);
    return match != null ? match.group(1)! : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.video.title)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AspectRatio(aspectRatio: 16 / 9, child: _buildVideoPlayer()),
            const SizedBox(height: 12),
            _buildControls(),
            const SizedBox(height: 20),
            Text(widget.video.description),
          ],
        ),
      ),
    );
  }

  //Video Player
  Widget _buildVideoPlayer() {
    if (widget.video.videoType == 'YouTube' && _youtubeController != null) {
      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        onReady: () {},
      );
    } else if (widget.video.videoType == 'Vimeo') {
      final videoId = extractVimeoId(widget.video.url);
      return FlutterVimeoPlayer(videoId: videoId, isAutoPlay: true);
    } else {
      return const Center(child: Text("Unsupported video type"));
    }
  }

  //Controls
  Widget _buildControls() {
    if (widget.video.videoType == 'YouTube' && _youtubeController != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.replay_10),
            onPressed: () => _youtubeController!.seekTo(
              _youtubeController!.value.position - const Duration(seconds: 10),
            ),
          ),
          IconButton(
            icon: Icon(
              _youtubeController!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
            onPressed: () => _youtubeController!.value.isPlaying
                ? _youtubeController!.pause()
                : _youtubeController!.play(),
          ),
          IconButton(
            icon: const Icon(Icons.forward_10),
            onPressed: () => _youtubeController!.seekTo(
              _youtubeController!.value.position + const Duration(seconds: 10),
            ),
          ),
        ],
      );
    }

    // Vimeo player from flutter_vimeo is embedded, can't control it easily.
    return const SizedBox.shrink();
  }
}
