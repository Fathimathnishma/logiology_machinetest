import 'package:flutter/material.dart';
import 'package:logiology_machinetest/features/home/model/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title ?? "Product Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.product.thumbnail != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.product.thumbnail!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),
                if (widget.product.title != null)
                  Text(
                    'Name: ${widget.product.title}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 8),
                if (widget.product.price != null)
                  Text(
                    'Price: \$${widget.product.price}',
                    style: TextStyle(fontSize: 16),
                  ),
                if (widget.product.rating != null)
                  Text(
                    'Rating: ${widget.product.rating}',
                    style: TextStyle(fontSize: 16),
                  ),
                if (widget.product.category != null)
                  Text(
                    'Category: ${widget.product.category}',
                    style: TextStyle(fontSize: 16),
                  ),
                if (widget.product.brand != null)
                  Text(
                    'Brand: ${widget.product.brand}',
                    style: TextStyle(fontSize: 16),
                  ),
                if (widget.product.tags != null &&
                    widget.product.tags!.isNotEmpty)
                  Text(
                    'Tags: ${widget.product.tags!.join(', ')}',
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
