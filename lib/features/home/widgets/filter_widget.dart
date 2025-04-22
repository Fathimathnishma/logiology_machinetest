import 'package:flutter/material.dart';
import 'package:logiology_machinetest/general/utils/app_colors.dart';

class PopupFilterWidget extends StatelessWidget {
  //final ProductController controller;

  //  PopupFilterWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
          //  topRight: Radius.circular(16),
        ),
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
          Row(
            children: [
              Text(
                " Category",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Category Input
          TextField(
            decoration: InputDecoration(labelText: 'Category'),
            onChanged: (value) {
              //   controller.categoryFilter.value = value;
            },
          ),
          Row(
            children: [
              Text(
                " Tag",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Tag Input
          TextField(
            decoration: InputDecoration(labelText: 'Tag'),
            onChanged: (value) {
              //    controller.tagFilter.value = value;
            },
          ),

          Row(
            children: [
              Text(
                "Price",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Max Price Input
          TextField(
            decoration: InputDecoration(labelText: 'Max Price'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              //   controller.priceFilter.value = double.tryParse(value) ?? double.infinity;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // controller.filterProducts(
              //   category: controller.categoryFilter.value,
              //   tag: controller.tagFilter.value,
              //   maxPrice: controller.priceFilter.value,
              // );
              // Get.back(); // Close the popup
            },
            child: Text("Apply Filter"),
          ),
        ],
      ),
    );
  }
}
