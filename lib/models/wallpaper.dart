class WallpaperModel {
  final String? id;
  final String? type;
  final String? file;
  final String? title;

  WallpaperModel({
     this.id,
     this.type,
     this.file,
     this.title,
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
