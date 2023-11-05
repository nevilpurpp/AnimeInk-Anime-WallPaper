import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/wallpaper.dart';
import '../utils/util.dart';

class GetDataProvider with ChangeNotifier {
  List<WallpaperModel> animeData = [];
  List<CategoryModel> categoryData = [];
  
  int currentPage = 1;
  int pageSize = 10; // Set the limit per page
  bool isLoading = false;
  bool hasMoreData = true;
  
//getting all images
  Future<void> fetchInitialData() async {
    if (isLoading) return;
    isLoading = true;
    
    try {
      final newAnimeData = await getpics(currentPage, pageSize);
      if (newAnimeData.isEmpty) {
        hasMoreData = false;
      } else {
        animeData.addAll(newAnimeData);
        currentPage++;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
//getting category images
  Future<List<WallpaperModel>> getpics(int page, int limit) async {
    try {
      final result = await http.get(
        Uri.https(
          'api.nekosapi.com',
          '/v3/images',
          {
            'page[limit]': '$limit',
            'page[offset]': '${page * limit}', // Calculate the offset based on the page and limit
            'filter[ageRating]': 'sfw',
          },
        ),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final data = jsonResponse['items'];

        if (data is List) {
          return data.map<WallpaperModel>((item) => WallpaperModel.fromMap(item)).toList();
        }
      }
    } catch (e) {
      Utils.showError(e.toString());
    }

    return [];
  }
  Future<List<CategoryModel>> getCategory()async{
    try{
final result = await http.get(
        Uri.https(
          'api.nekosapi.com',
          '/v3/images/tags',
          {
             'filter[ageRating]': 'sfw',
          }
        ),
        
        headers: {
          'Accept': 'application/json',
        },
      );

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final data = jsonResponse['items'];

        if (data is List) {
          return data.map<CategoryModel>((item) => CategoryModel.fromJson(item)).toList();
        }
      }
    }catch(e){
      print(e);
       Utils.showError(e.toString());
    }
    return [];
}
 Future<void> fetchCategoryImages(String categoryId) async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    try {
      final newCategoryImages = await getCategoryImages(categoryId, currentPage, pageSize);
      if (newCategoryImages.isEmpty) {
        hasMoreData = false;
      } else {
        animeData.addAll(newCategoryImages);
        currentPage++;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<WallpaperModel>> getCategoryImages(String categoryId, int page, int limit) async {
    try {
      final result = await http.get(
        Uri.https(
          'api.nekosapi.com',
          '/v3/images/tags/$categoryId',
          {
            'page[limit]': '$limit',
            'page[offset]': '${page * limit}',
            'filter[ageRating]': 'sfw',
          },
        ),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final data = jsonResponse['items'];

        if (data is List) {
          return data.map<WallpaperModel>((item) => WallpaperModel.fromMap(item)).toList();
        }
      }
    } catch (e) {
      print('Error fetching category images: $e');
    }

    return [];
  }

}