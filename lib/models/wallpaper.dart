class WallpaperModel {
  final int id;
  final String idV2;
  final String imageUrl;

  WallpaperModel({
     required this.id,
     required this.idV2,
     required this.imageUrl,
    
  });

  factory WallpaperModel.fromMap(Map<String, dynamic> json) {
    return WallpaperModel(
    id: json['id'],
        idV2: json['id_v2'],
        imageUrl: json['image_url'],
    );
  }
}
