class Subject {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Subject({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image'],
    );
  }
}
