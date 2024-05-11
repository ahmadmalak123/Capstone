import 'dart:async';
import 'package:flutter/material.dart';
import 'pet_home_page.dart';
import 'pets_page.dart';
import 'petshop_page.dart';
import 'Side_Pages/notifications_page.dart';
import 'calendar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late final PageController _pageController;
  final _photos = [
    {
      'title': 'Photo 1',
      'description': 'Description 1',
      'imagePath': 'assets/Checkup1.jpeg',
    },
    {
      'title': 'Photo 2',
      'description': 'Description 2',
      'imagePath': 'assets/Checkup2.jpeg',
    },
    {
      'title': 'Photo 3',
      'description': 'Description 3',
      'imagePath': 'assets/Checkup3.jpeg',
    },
    // Add more photos with information as needed
  ];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _photos.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Services'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'All the services you need!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildAutoScrollPhotoCarousel(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Request an appointment for a:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildServiceCard(context, 'Medication Refill', Icons.medication),
            _buildServiceCard(context, 'Routine Check-ups', Icons.medical_services),
            _buildServiceCard(context, 'Grooming Services', Icons.cut),
            _buildServiceCard(context, 'Diagnostic Testing', Icons.local_hospital),
            _buildServiceCard(context, 'Dental Care', Icons.masks),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RateVetPage()),
                  );
                },
                child: Text('Rate Vet'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String serviceName, IconData icon) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(serviceName),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppointmentBookingPage(serviceName: serviceName)),
          );
        },
      ),
    );
  }

  Widget _buildAutoScrollPhotoCarousel() {
    return Container(
      height: 350, // Adjust height as needed
      child: PageView.builder(
        controller: _pageController,
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          return _buildPhotoWithInformation(
            _photos[index]['title']!,
            _photos[index]['description']!,
            _photos[index]['imagePath']!,
          );
        },
      ),
    );
  }

  Widget _buildPhotoWithInformation(String title, String description, String imagePath) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.black.withOpacity(0.5), // Slightly darker for better text visibility
              ),
              child: Text(
                title + "\n" + description,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentBookingPage extends StatelessWidget {
  final String serviceName;

  const AppointmentBookingPage({Key? key, required this.serviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service: $serviceName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Select Date:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action to select date
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            Text(
              'Select Vet:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // Add dropdown or other input for vet selection
            ElevatedButton(
              onPressed: () {
                // Action to select vet
              },
              child: Text('Select Vet'),
            ),
            SizedBox(height: 20),
            Text(
              'Comments:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter comments (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action to confirm appointment booking
              },
              child: Text('Request Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
class RateVetPage extends StatefulWidget {
  @override
  _RateVetPageState createState() => _RateVetPageState();
}

class _RateVetPageState extends State<RateVetPage> {
  final List<String> vets = ['Dr. Smith', 'Dr. Johnson', 'Dr. Emily'];  // Example vets
  String? selectedVet;
  double _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate a Vet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select a Vet:', style: TextStyle(fontSize: 20)),
            DropdownButton<String>(
              value: selectedVet,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedVet = newValue!;
                });
              },
              items: vets.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Rate the Vet:', style: TextStyle(fontSize: 20)),
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
                // Submit the review to the backend
                // Here you should implement your backend logic
                // e.g., POST request to your API
                print('Review submitted for $selectedVet with rating $_currentRating');
                // Place for backend integration comment
                // "Insert your backend function here to handle the review submission"
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}