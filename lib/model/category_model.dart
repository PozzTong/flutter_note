// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

import 'package:flutter_app_vscode/global/constant/data_fiels.dart';

class CategoryModel {
  late int id;
  late String name;
  CategoryModel(
      {required this.id, required this.name});
  Map<String, dynamic> toMap() {
    return {category_id: id, categiry_name: name};
  }

  CategoryModel.fromMap(Map<String, dynamic> res)
      : id = res[category_id],
        name = res[categiry_name];
}

List<CategoryModel> categorys = [
  CategoryModel(id: 1, name: 'Person'),
  CategoryModel(id: 2, name: 'Work')
];
