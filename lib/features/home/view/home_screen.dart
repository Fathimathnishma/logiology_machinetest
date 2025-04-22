import 'package:flutter/material.dart';
import 'package:logiology_machinetest/features/home/widgets/filter_widget.dart';
import 'package:logiology_machinetest/general/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(radius: 22),
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
                    child: PopupFilterWidget(), // Your PopupFilterWidget
                  );
                },
              );
            },
            child: Icon(Icons.filter_list_outlined, size: 32),
          ),
          SizedBox(width: 13),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              cursorHeight: 23,
              decoration: InputDecoration(
                labelText: "Search by name",
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 8, // Placeholder for the number of items
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder for product image
                      Container(height: 100, color: Colors.grey[300]),
                      SizedBox(height: 8),
                      Text(
                        "Product Title",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        'Rating: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
