import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trogan_learning_app/core/utils.dart';
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
    if (widget.video.type == VideoType.youtube) {
      final videoId = YoutubePlayer.convertUrlToId(widget.video.url);
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId ?? '',
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

   String extractVimeoId(String url) {
  final regex = RegExp(r'vimeo\.com/(?:video/)?(\d+)');
  final match = regex.firstMatch(url);
  return match != null ? match.group(1)! : '';

    }

  void toggleFullScreen() {
  final deviceType = Utils.getDeviceType(context);

  if (deviceType == DeviceType.mobile || deviceType == DeviceType.tablet) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    if (isPortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _buildVideoPlayer(),
            ),
            const SizedBox(height: 12),
            _buildControls(),
            const SizedBox(height: 20),
            Text(widget.video.description),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (widget.video.type == VideoType.youtube && _youtubeController != null) {
      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        onReady: () {},
      );
    } else if (widget.video.type == VideoType.vimeo) {
      return FlutterVimeoPlayer(videoId: extractVimeoId(widget.video.url), isAutoPlay: true,);
    } else {
      return const Center(child: Text("Unsupported video type"));
    }
  }

  Widget _buildControls() {
    if (widget.video.type == VideoType.youtube && _youtubeController != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.replay_10),
            onPressed: () => _youtubeController!
                .seekTo(_youtubeController!.value.position - const Duration(seconds: 10)),
          ),
          IconButton(
            icon: Icon(_youtubeController!.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow),
            onPressed: () => _youtubeController!.value.isPlaying
                ? _youtubeController!.pause()
                : _youtubeController!.play(),
          ),
          IconButton(
            icon: const Icon(Icons.forward_10),
            onPressed: () => _youtubeController!
                .seekTo(_youtubeController!.value.position + const Duration(seconds: 10)),
          ),
          IconButton(
            icon: const Icon(Icons.fullscreen),
            onPressed: toggleFullScreen,
          ),
        ],
      );
    }

    // Vimeo player from flutter_vimeo is embedded, can't control it easily.
    return const SizedBox.shrink();
  }
}
