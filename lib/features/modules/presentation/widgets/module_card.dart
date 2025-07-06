import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trogan_learning_app/core/color_palette.dart';
import 'package:trogan_learning_app/features/videos/controller/video_cubit.dart';
import 'package:trogan_learning_app/features/videos/presentation/screens/video_player_screen.dart';
import 'package:trogan_learning_app/models/module.dart';

class ModuleCard extends StatelessWidget {
  final Module module;
  const ModuleCard({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoCubit, VideoState>(
      listener: (context, state) {
        if (state is VideoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is VideoSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(video: state.video),
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          context.read<VideoCubit>().fetchVideos(module.id);
        },
        child: Container(
          constraints: const BoxConstraints(maxHeight: 70, maxWidth: 300),
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorPalette.moduleCardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(
                Icons.play_circle_outline,
                color: ColorPalette.onModule,
                size: 35,
              ),
              const SizedBox(width: 12),
              Container(
                width: 1,
                height: double.infinity,
                color: ColorPalette.onModule,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: GoogleFonts.nunito(
                        color: ColorPalette.onModule,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      module.description,
                      style: GoogleFonts.nunito(
                        color: ColorPalette.onModule,
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
      ),
    );
  }
}
