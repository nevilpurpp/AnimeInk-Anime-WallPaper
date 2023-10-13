import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'category.dart';
import 'wallpaper.dart';

class HttpHelper {
  // ...

  int currentPage = 0; // Track the current page

  Future<List<WallpaperModel>> getpics() async {
    final result = await http.get(
      Uri.https(
        'api.nekosapi.com',
        '/v2/images',
        {
          'page[limit]': '50', // Set the limit per page
          'page[offset]': '$currentPage', // Set the offset to fetch the next page
        },
      ),
      headers: {
        'Accept': 'application/vnd.api+json',
      },
    );

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);

      // Increment the current page for the next request
      currentPage++;

      // Access the "data" key in the JSON response
      final data = jsonResponse["data"];

      if (data is List) {
        // Map the list of objects to WallpaperModel
        List<WallpaperModel> anime = data
            .map<WallpaperModel>((i) => WallpaperModel.fromMap(i))
            .toList();
        return anime;
      } else {
        // Handle the case where "data" is not a List
        return [];
      }
    } else {
      return [];
    }
  }
  Future<List<CategoryModel>> getCategories() async {
  final result = await http.get(
    Uri.https('api.nekosapi.com', '/v2/categories'),
    headers: {
      'Accept': 'application/vnd.api+json',
    },
  );

  if (result.statusCode == HttpStatus.ok) {
    final jsonResponse = json.decode(result.body);
    final data = jsonResponse["data"];

    if (data is List) {
      // Map the list of objects to Category
     List<CategoryModel> categories = data
    .map<CategoryModel>((json) => CategoryModel.fromJson(json))
    .toList();

      return categories;
    } else {
      // Handle the case where "data" is not a List
      return [];
    }
  } else {
    return [];
  }
}

}
