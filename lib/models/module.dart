class Module {
  final int id;
  final String title;
  final String description;

  Module({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: int.parse(json['id'].toString()),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
