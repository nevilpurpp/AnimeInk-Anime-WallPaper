class WallpaperModel {
  final String? id;
  final String? type;
  final String file;
  final String? title;

  WallpaperModel({
    required this.id,
    required this.type,
    required this.file,
    required this.title,
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> json) {
    return WallpaperModel(
      id: json["id"],
      type: json["type"],
      file: json['attributes']["file"],
      title: json['attributes']["title"],
    );
  }
}
