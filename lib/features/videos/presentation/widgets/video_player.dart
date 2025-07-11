import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_vimeo/flutter_vimeo.dart';
import 'package:trogan_learning_app/models/video.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Video video;
  final void Function(YoutubePlayerController controller)? onYouTubeInit;

  const VideoPlayerWidget({
    super.key,
    required this.video,
    this.onYouTubeInit,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    if (widget.video.videoType == 'YouTube') {
      final videoId = Uri.parse(widget.video.url).queryParameters['v'] ?? '';
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: true,
        ),
      );
      widget.onYouTubeInit?.call(_youtubeController!);
    }
  }

  String _extractVimeoId(String url) {
    final match = RegExp(r'vimeo\.com/(?:video/)?(\d+)').firstMatch(url);
    return match != null ? match.group(1)! : '';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.video.videoType == 'YouTube' && _youtubeController != null) {
      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
      );
    } else if (widget.video.videoType == 'Vimeo') {
      final videoId = _extractVimeoId(widget.video.url);
      return FlutterVimeoPlayer(videoId: videoId, isAutoPlay: true);
    } else {
      return const Center(child: Text("Unsupported video type"));
    }
  }
}
