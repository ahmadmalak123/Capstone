import 'package:flutter/material.dart';
import '../models/for_pet_owner/product.dart';
import 'product_reviews_page.dart';

// Product Detail Page with centered content
class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.transparent,
        // Set the AppBar background to transparent
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(product.imageAsset, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  Text(product.description, textAlign: TextAlign.center),
                  Text('Price: \$${product.price}', style: TextStyle(color: Colors.green), textAlign: TextAlign.center),
                  Text('Category: ${product.category}', textAlign: TextAlign.center),
                  Text('Quantity in Stock: ${product.quantityInStock}', textAlign: TextAlign.center),
                  Text('Pet Genre: ${product.petGenre}', textAlign: TextAlign.center),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductReviewsPage(product: product)),
                      );
                    },
                    child: Text('View Reviews', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor, // Replace 'primary' with 'backgroundColor'
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
