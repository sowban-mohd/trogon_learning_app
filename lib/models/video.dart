enum VideoType { youtube, vimeo }

class Video {
  final String url;
  final VideoType type;
  final String title;
  final String description;

  Video({
    required this.url,
    required this.type,
    required this.title,
    required this.description,
  });


  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      url: json['url'] as String,
      type: json['type'] == 'YouTube' ? VideoType.youtube : VideoType.vimeo,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
