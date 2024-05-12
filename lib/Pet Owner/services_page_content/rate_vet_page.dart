import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateVetPage extends StatefulWidget {
  final String vetName;

  RateVetPage({Key? key, required this.vetName}) : super(key: key);

  @override
  _RateVetPageState createState() => _RateVetPageState();
}

class _RateVetPageState extends State<RateVetPage> {
  int _currentRating = 0;  // Change to int to ensure we are using integer ratings

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate ${widget.vetName}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rate the Vet:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _currentRating.toDouble(), // Convert int to double for the RatingBar
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false, // Ensure only full rating increments
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating.round(); // Round and store as int
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your review here',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to submit review to the backend
                print('Review submitted for ${widget.vetName} with rating $_currentRating');
                // Additional backend integration may be implemented here
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
