
class WallpaperModel {
  final String artId;
  final String animename;
  final String arturl;
  final int sensitivity;

  WallpaperModel({
    required this.artId,
    required this.animename,
    required this.arturl,
    required this.sensitivity,
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> json){
    return WallpaperModel(
      artId: json["art_id"],
      animename: json["animename"],
      arturl: json["arturl"],
      sensitivity: json["sensitivity"],
    );
  }
}









