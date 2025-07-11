import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trogan_learning_app/core/color_palette.dart';
import 'package:trogan_learning_app/features/videos/presentation/screens/video_player_screen.dart';
import 'package:trogan_learning_app/models/video.dart';

class VideoListCard extends StatelessWidget {
  final Video video;
  const VideoListCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => VideoPlayerScreen(video: video)),
        );
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 70, maxWidth: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorPalette.videoCardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              Icons.play_circle_outline,
              color: ColorPalette.onVideoCard,
              size: 35,
            ),
            const SizedBox(width: 12),
            Container(
              width: 1,
              height: double.infinity,
              color: ColorPalette.onVideoCard,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: GoogleFonts.nunito(
                      color: ColorPalette.onVideoCard,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    video.description,
                    style: GoogleFonts.nunito(
                      color: ColorPalette.onVideoCard,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
