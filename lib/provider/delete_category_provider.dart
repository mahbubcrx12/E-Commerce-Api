import 'package:e_commerce_api/api_service/custom_api.dart';
import 'package:e_commerce_api/model/category_model.dart';
import 'package:flutter/material.dart';

class DeleteCategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];
  getCategoryData() async {
    
    notifyListeners();
  }
}
