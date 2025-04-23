import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:logiology_machinetest/features/home/presentation/controller/product_controller.dart';
import 'package:logiology_machinetest/general/utils/app_colors.dart';

class PopupFilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          TextField(
            controller: productController.selectedCategory,
            decoration: InputDecoration(labelText: 'Enter Category'),
          ),

          SizedBox(height: 10),
          TextField(
            controller: productController.selectedTag,
            decoration: InputDecoration(labelText: 'Enter Tag'),
            onChanged: (value) {},
          ),

          SizedBox(height: 10),
          TextField(
            controller: productController.maxPrice,
            decoration: InputDecoration(labelText: 'Max Price'),
            keyboardType: TextInputType.number,
            onChanged: (value) {},
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              productController.applyFilters();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Apply Filter", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
