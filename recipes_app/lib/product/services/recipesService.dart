import 'dart:io';

import 'package:dio/dio.dart';
import 'package:recipes_app/product/models/recipesModel.dart';

class Recipesservice {
  
  final Dio _dio = Dio();

Future<RecipiesModel> fetchRecipes () async{
  try {
  final response = await _dio.get('https://dummyjson.com/recipes');

  if (response.statusCode == HttpStatus.ok) {
    return RecipiesModel.fromJson(response.data);
  }else{
    throw Exception("Yemekler yüklenirken hata oluştu");
  }
  } catch (e) {
    throw Exception('yemekler yüklenemedi: $e');
  }
}


}