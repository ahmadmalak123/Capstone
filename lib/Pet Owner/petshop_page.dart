import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';  // Ensure this package is added in your pubspec.yaml
import 'Side_Pages/notifications_page.dart';
import 'services.dart';
import 'calendar.dart';
import 'pets_page.dart';
import 'home_page.dart';

// Product model class
class Product {
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageAsset;
  final int quantityInStock;
  final String petGenre;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageAsset,
    required this.quantityInStock,
    required this.petGenre,
  });
}

// Main PetShopPage
class PetShopPage extends StatefulWidget {
  const PetShopPage({Key? key}) : super(key: key);

  @override
  State<PetShopPage> createState() => _PetShopPageState();
}

class _PetShopPageState extends State<PetShopPage> {
  List<String> cartItems = [];
  List<Product> products = [
    Product(
      name: 'Dog Bone',
      description: 'A delicious treat for your canine friend.',
      price: 5.99,
      category: 'Food',
      imageAsset: 'assets/Untitled1.jpeg',
      quantityInStock: 20,
      petGenre: 'Dogs',
    ),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Pet Shop'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                // Placeholder for notifications navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
              icon: Icon(Icons.notifications),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildFilterButtons(),
            SizedBox(height: 20),
            _buildProductList(context),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems)),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.shopping_cart),
            if (cartItems.isNotEmpty) // Check if there are items in the cart
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    cartItems.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Pets'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Pet Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Calendar'),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetsPage()),
            );
          } else if (index == 2) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PetShopPage()),
            );
          } else if (index == 3) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ServicesPage()),
            );
          } else if (index == 4) {
            // Navigate to pets page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterButton('All'),
          _buildFilterButton('Dogs'),
          _buildFilterButton('Cats'),
          _buildFilterButton('Fish'),
          _buildFilterButton('Birds'),
          _buildFilterButton('Reptiles'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(text),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)),
            );
          },
          child: _buildProductCard(product),
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(product.imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '\$${product.price}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    if (!cartItems.contains(product.name)) {
                      setState(() {
                        cartItems.add(product.name);
                      });
                    }
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Product Detail Page with centered content
class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
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
                    child: Text('View Reviews'),
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

// Cart Page
class CartPage extends StatelessWidget {
  final List<String> cartItems;

  CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                // Action to remove the item from the cart
                print('Remove ${cartItems[index]} from cart');
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            onPressed: () {
              print('Proceed to checkout');
            },
            child: Text('Proceed to Checkout'),
          ),
        ),
      ),
    );
  }
}

// Product Reviews Page
class ProductReviewsPage extends StatelessWidget {
  final Product product;

  ProductReviewsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample reviews
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
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reviews[index]['user']),
            subtitle: Text(reviews[index]['comment']),
            trailing: RatingBarIndicator(
              rating: reviews[index]['rating'],
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
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
        tooltip: 'Write Review',
      ),
    );
  }
}

// Write Review Page
class WriteReviewPage extends StatelessWidget {
  final Product product;

  WriteReviewPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _reviewController = TextEditingController();
    double _currentRating = 3.0;  // Default or initial rating

    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Review'),
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
                _currentRating = rating;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Submit the review to the backend
                print('Review submitted for ${product.name} with rating $_currentRating and comments: ${_reviewController.text}');
                // Here you should implement your backend logic
                // e.g., POST request to your API
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
