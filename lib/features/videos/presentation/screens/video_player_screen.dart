import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trogan_learning_app/core/color_palette.dart';

import 'package:trogan_learning_app/features/videos/presentation/widgets/video_player.dart';
import 'package:trogan_learning_app/features/videos/presentation/widgets/youtube_controls.dart';
import 'package:trogan_learning_app/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? _youtubeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button row
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () async {
                    final orientation = MediaQuery.of(context).orientation;
                    if (orientation == Orientation.landscape) {
                      await SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                    }
                    if(context.mounted) Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only( top: 24.0, left: 4, right: 4 ),
                child: Column(
                  children: [
                    // Video Player
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayerWidget(
                        video: widget.video,
                        onYouTubeInit: (controller) {
                          _youtubeController = controller;
                        },
                      ),
                    ),
                    const SizedBox(height: 12),

                    // YouTube Controls
                    if (widget.video.videoType == 'YouTube' &&
                        _youtubeController != null)
                      YouTubeControlsWidget(controller: _youtubeController!),

                    const SizedBox(height: 20),

                    // Title and Description
                    Text(
                      widget.video.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.video.description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
}
