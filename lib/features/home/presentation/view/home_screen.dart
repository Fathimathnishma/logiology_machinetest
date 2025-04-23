import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology_machinetest/features/home/presentation/controller/product_controller.dart';
import 'package:logiology_machinetest/features/home/presentation/view/details_screen.dart';
import 'package:logiology_machinetest/features/home/widgets/filter_widget.dart';
import 'package:logiology_machinetest/features/profile/controller/profile_Controller.dart';
import 'package:logiology_machinetest/features/profile/view/profil_screen.dart';
import 'package:logiology_machinetest/general/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilScreen()),
              );
            },
            child: Obx(() {
              return CircleAvatar(
                radius: 22,
                backgroundImage:
                    profileController.profileImgUrl.value.isNotEmpty
                        ? FileImage(File(profileController.profileImgUrl.value))
                        : null,
                child:
                    profileController.profileImgUrl.value.isEmpty
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
              );
            }),
          ),
          SizedBox(width: 13),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: PopupFilterWidget(),
                  );
                },
              );
            },
            child: Icon(Icons.filter_list_outlined, size: 32),
          ),
          SizedBox(width: 13),
        ],
      ),
      body: Obx(() {
        return productController.isLoading.isTrue
            ? Center(child: CircularProgressIndicator())
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: productController.searchController,
                    onChanged: (value) {
                      productController
                          .applyFilters(); // Apply filters when search text changes
                    },
                    decoration: InputDecoration(
                      labelText: "Search by name or Category",
                      labelStyle: TextStyle(
                        color: AppColors.blackColor.withOpacity(0.5),
                        fontSize: 12,
                      ),
                      prefixIcon: Icon(Icons.search, size: 19),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide(color: AppColors.blackColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      productController.filteredProducts.isEmpty
                          ? Center(
                            child: Text(
                              "Oops, no product found 😞",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.blackColor,
                              ),
                            ),
                          )
                          : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                            itemCount:
                                productController.filteredProducts.length,
                            itemBuilder: (context, index) {
                              final data =
                                  productController.filteredProducts[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ProductDetailScreen(
                                            product: data,
                                          ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              data.thumbnail!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.title!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '\$${data.price.toString()}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.blackColor,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Rating: ${data.rating}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.blackColor
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            );
      }),
    );
  }
}
