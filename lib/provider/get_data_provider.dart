import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/category.dart';
import '../models/wallpaper.dart';
import '../utils/util.dart';

class GetDataProvider with ChangeNotifier {
  List<WallpaperModel> animeData = [];
  List<CategoryModel> categoryData = [];
  int currentPage = 1;
  int pageSize = 50; // Set the limit per page
  bool isLoading = false;
  bool hasMoreData = true;
  

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

  Future<List<WallpaperModel>> getpics(int page, int limit) async {
    try {
      final result = await http.get(
        Uri.https(
          'api.nekosapi.com',
          '/v2/images',
          {
            'page[limit]': '$limit',
            'page[offset]': '${page * limit}', // Calculate the offset based on the page and limit
            'filter[ageRating]': 'sfw',
          },
        ),
        headers: {
          'Accept': 'application/vnd.api+json',
        },
      );

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final data = jsonResponse['data'];

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
          '/v2/categories',
        ),
        headers: {
          'Accept': 'application/vnd.api+json',
        },
      );

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final data = jsonResponse['data'];

        if (data is List) {
          return data.map<CategoryModel>((item) => CategoryModel.fromJson(item)).toList();
        }
      }
    }catch(e){
       Utils.showError(e.toString());
    }
    return [];
}
}