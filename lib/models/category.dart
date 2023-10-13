class CategoryModel {
  final String id;
  final String name;
  final bool isNsfw;
  final List<String> imageIds;

  CategoryModel({
    required this.id,
    required this.name,
    required this.isNsfw,
    required this.imageIds,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['attributes']['name'],
      isNsfw: json['attributes']['isNsfw'],
      imageIds: (json['relationships']['images']['data'] as List)
          .map<String>((image) => image['id'] as String)
          .toList(),
    );
  }
}
