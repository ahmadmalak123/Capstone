import 'package:flutter/material.dart';
import '../models/for_pet_owner/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'write_reviews_page.dart';
const Color kPrimaryColor = Color(0xFF00C853);  // Example green color
const Color kAccentColor = Color(0xFF6200EA);
// Product Reviews Page
class ProductReviewsPage extends StatelessWidget {
  final Product product;

  ProductReviewsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> reviews = [
      {
        'user': 'John Doe',
        'comment': 'Great product, my dog loves it!',
        'rating': 5.0,
      },
      {
        'user': 'Jane Smith',
        'comment': 'Not bad, but could be cheaper.',
        'rating': 3.5,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Reviews'),
        backgroundColor: Colors.transparent,
        // Set the AppBar background to transparent
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reviews[index]['user']),
            subtitle: Text(reviews[index]['comment']),
            trailing: RatingBarIndicator(
              rating: reviews[index]['rating'],
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WriteReviewPage(product: product)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: kAccentColor,
        tooltip: 'Write Review',
      ),
    );
  }
}
