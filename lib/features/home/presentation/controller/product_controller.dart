import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology_machinetest/features/home/model/product_model.dart';
import 'package:logiology_machinetest/features/home/service/product_service.dart';

class ProductController extends GetxController {
  var productModel = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var isLoading = false.obs;
  var isFiltering = false.obs;

  final TextEditingController selectedCategory = TextEditingController();
  final TextEditingController selectedTag = TextEditingController();
  final TextEditingController maxPrice = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    try {
      isLoading.value = true;
      final data = await ProductService().fetchProducts();
      if (data != null) {
        productModel.value = data;
        filteredProducts.value = data; // Initialize with full dataset
        isFiltering.value = false; // Ensure filtering state is reset
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // FILTERING AND SEARCH FUNCTION

  void applyFilters() {
    isFiltering.value = true;
    filteredProducts.value =
        productModel.where((product) {
          bool matchesCategory =
              selectedCategory.text.isEmpty ||
              product.category == selectedCategory.text;
          bool matchesTag =
              selectedTag.text.isEmpty ||
              product.tags?.contains(selectedTag.text) == true;
          bool matchesPrice =
              maxPrice.text.isEmpty ||
              (double.tryParse(maxPrice.text) ?? double.infinity) >=
                  (product.price?.toDouble() ?? double.infinity);
          bool matchesSearch =
              product.title!.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ) ||
              product.category!.toLowerCase().contains(
                searchController.text.toLowerCase(),
              );

          return matchesCategory && matchesTag && matchesPrice && matchesSearch;
        }).toList();
    isFiltering.value = false;
  }

  List<ProductModel> get displayedProducts =>
      isFiltering.value ? filteredProducts : productModel;
}
