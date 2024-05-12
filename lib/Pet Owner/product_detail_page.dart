import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_reviews_page.dart';

// Define a global or local theme color variable as needed
const Color kAccentColor = Colors.blue;  // Define this in your global settings if not already

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            product.image != null
                ? Image.memory(
              product.image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image, size: 50, color: Colors.grey); // Fallback if image fails
              },
            )
                : Image.asset('assets/placeholder.jpeg', fit: BoxFit.cover),  // Placeholder image
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(product.name ?? "No name available", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  Text(product.description ?? "No description available", textAlign: TextAlign.center),
                  Text('Price: \$${product.price?.toStringAsFixed(2) ?? 'N/A'}', style: TextStyle(color: Colors.green), textAlign: TextAlign.center),
                  Text('Category: ${product.category ?? 'N/A'}', textAlign: TextAlign.center),
                  Text('Quantity in Stock: ${product.quantity?.toString() ?? 'N/A'}', textAlign: TextAlign.center),
                  Text('Pet Genre: ${product.petGenre ?? 'N/A'}', textAlign: TextAlign.center),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductReviewsPage(product: product)),
                      );
                    },
                    child: Text('View Reviews', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
