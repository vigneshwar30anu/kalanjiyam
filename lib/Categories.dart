// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
    this.id,
    this.categoryName,
    this.author,
    this.image,
  });

  String id;
  String categoryName;
  String author;
  String image;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        categoryName: json["category_name"],
        author: json["author"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "author": author,
        "image": image,
      };
}
