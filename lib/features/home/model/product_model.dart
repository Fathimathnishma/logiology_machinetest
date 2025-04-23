import 'dart:convert';

class ProductModel {
  final String? title;
  final num? price;
  final num? rating;
  final String? thumbnail;
  final String? category;
  final String? brand;
  final List<String>? tags;

  ProductModel({
    this.title,
    this.price,
    this.rating,
    this.thumbnail,
    this.category,
    this.brand,
    this.tags,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'] as String?,
      price: map['price'] as num?,
      rating: map['rating'] as num?,
      thumbnail: map['thumbnail'] as String?,
      category: map['category'] as String?,
      brand: map['brand'] as String?,
      tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail,
      'category': category,
      'brand': brand,
      'tags': tags,
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
