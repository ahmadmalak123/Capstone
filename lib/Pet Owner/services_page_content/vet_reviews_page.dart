import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../ApiHandler.dart';
import '../../models/for_vet/review.dart';
import 'rate_vet_page.dart';

class VetReviewsPage extends StatelessWidget {
  final int vetId;
  final String vetName;

  VetReviewsPage({required this.vetId, required this.vetName});

  Future<List<Review>> _fetchReviews(BuildContext context) async {
    try {
      return ApiHandler().getReviewsByVetId(vetId);
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vet Reviews'),
      ),
      body: FutureBuilder<List<Review>>(
        future: _fetchReviews(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            // No reviews found
            return Center(
              child: Text(
                'There are no reviews on this vet.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.map((review) => _buildReviewCard(context, review)).toList(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RateVetPage(vetName: vetName), // Use vetName here
              ),
            );
          },
          child: Text('Rate Vet'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, Review review) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${review.firstName} ${review.lastName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            RatingBarIndicator(
              rating: review.rating.toDouble(),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
            SizedBox(height: 8),
            Text(review.comment, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(
              'Date: ${review.date.month}/${review.date.day}/${review.date.year}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
