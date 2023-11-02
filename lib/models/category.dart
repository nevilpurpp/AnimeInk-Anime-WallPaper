class CategoryModel {
  final List<CategoryItem> items;
  final int count;

  CategoryModel({
    required this.items,
    required this.count,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsList = json['items'];
    final List<CategoryItem> categoryItems = itemsList
        .map((item) => CategoryItem.fromJson(item))
        .toList();

    return CategoryModel(
      items: categoryItems,
      count: json['count'],
    );
  }
}

class CategoryItem {
  final int id;
  final String idV2;
  final String name;
  final String description;
  final String sub;
  final bool isNsfw;

  CategoryItem({
    required this.id,
    required this.idV2,
    required this.name,
    required this.description,
    required this.sub,
    required this.isNsfw,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      idV2: json['id_v2'],
      name: json['name'],
      description: json['description'],
      sub: json['sub'],
      isNsfw: json['is_nsfw'],
    );
  }
}

