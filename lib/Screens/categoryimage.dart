import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/wallpaper.dart';
import '../provider/get_data_provider.dart';

class CategoryImagePage extends StatefulWidget {
  final CategoryModel category;

  CategoryImagePage({required this.category});

  @override
  State<CategoryImagePage> createState() => _CategoryImagePageState();
}

class _CategoryImagePageState extends State<CategoryImagePage> {  
  final GetDataProvider dataProvider = GetDataProvider();
  List<WallpaperModel> categoryImages = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryImages();
  }

  Future<void> fetchCategoryImages() async {
    final images = await dataProvider.getCategoryImages(widget.category.id.toString());
    setState(() {
      categoryImages = images;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name!),
      ),
      body: ListView.builder(
        itemCount: categoryImages.length,
        itemBuilder: (context, index) {
          final wallpaper = categoryImages[index];
          return Image.network(wallpaper.imageUrl);
        },
      ),
    );
  }
}
