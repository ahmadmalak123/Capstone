import 'package:flutter/material.dart';
import '../models/for_pet_owner/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Write Review Page
class WriteReviewPage extends StatefulWidget {
  final Product product;

  WriteReviewPage({Key? key, required this.product}) : super(key: key);

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  TextEditingController _reviewController = TextEditingController();
  double _currentRating = 3.0;  // Default or initial rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Review'),
        backgroundColor: Colors.transparent,
        // Set the AppBar background to transparent
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: 'Enter your review here',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            Text('Rate the product:', style: TextStyle(fontSize: 20)),
            RatingBar.builder(
              initialRating: _currentRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Submit the review to the backend
                print('Review submitted for ${widget.product.name} with rating $_currentRating and comments: ${_reviewController.text}');
                // Here you should implement your backend logic
                // e.g., POST request to your API
                // "Insert your backend function here to handle the review submission"
              },
              child: Text('Submit Review', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                // Set the AppBar background to transparent
                elevation: 0, // Replace 'primary' with 'backgroundColor'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
