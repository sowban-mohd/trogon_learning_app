
class Video {
  final String url;
  final String videoType;
  final String title;
  final String description;

  Video({
    required this.url,
    required this.videoType,
    required this.title,
    required this.description,
  });


  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      url: json['video_url'] ?? '',
      videoType: json['video_type'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
