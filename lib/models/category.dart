class CategoryModel {
  final int? id;
  final String? idV2;
  final String? name;
  final String? description;
  final String? sub;
  final bool isNsfw;

  CategoryModel({
    required this.id,
    required this.idV2,
    required this.name,
    required this.description,
    required this.sub,
    required this.isNsfw,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      idV2: json['id_v2'],
      name: json['name'],
      description: json['description'],
      sub: json['sub'],
      isNsfw: json['is_nsfw'],
    );
  }
}

