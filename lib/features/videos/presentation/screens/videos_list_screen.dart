import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trogan_learning_app/core/color_palette.dart';
import 'package:trogan_learning_app/core/loader.dart';
import 'package:trogan_learning_app/core/utils.dart';
import 'package:trogan_learning_app/features/videos/controller/video_cubit.dart';
import 'package:trogan_learning_app/features/videos/presentation/widgets/video_list_card.dart';
import 'package:trogan_learning_app/models/video.dart';

class VideosListScreen extends StatefulWidget {
  final String moduleName;
  final int moduleId;
  const VideosListScreen({
    super.key,
    required this.moduleName,
    required this.moduleId,
  });

  @override
  State<VideosListScreen> createState() => _VideosListScreenState();
}

class _VideosListScreenState extends State<VideosListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VideoCubit>().fetchVideos(widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Learning App',
              style: GoogleFonts.changa(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: ColorPalette.dividerColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<VideoCubit, VideoState>(
          listener: (context, state) {
            if (state is VideoError) {
              Utils.showSnackBar(context, message: state.message);
            }
          },
          builder: (context, state) {
            if (state is VideoLoading) {
              return const Loader();
            } else if (state is VideoSuccess) {
              final List<Video> videos = state.videos;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      widget.moduleName,
                      style: GoogleFonts.nunito(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.onSurface,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return VideoListCard(video: videos[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}