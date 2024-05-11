import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/for_pet_owner/product.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';

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
      imageAsset: 'assets/dog_bone.jpg', // Ensure this asset is available in your project
      quantityInStock: 20,
      petGenre: 'Dogs',
    ),
    Product(
      name: 'Cat Toy',
      description: 'Fun and engaging toy for cats.',
      price: 4.50,
      category: 'Toys',
      imageAsset: 'assets/cat_toys.jpg', // Make sure this asset exists in your project
      quantityInStock: 15,
      petGenre: 'Cats',
    ),
    Product(
      name: 'Fish Food',
      description: 'Nutritious food for all types of fish.',
      price: 3.99,
      category: 'Food',
      imageAsset: 'assets/fish_food.jpg', // Make sure this asset exists in your project
      quantityInStock: 30,
      petGenre: 'Fish',
    )
    // Add more products as needed
  ];
  String filter = 'All';
  String searchQuery = ''; // State variable to hold the search query

  void searchProducts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Pet Shop', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: TextField(
                  onChanged: (value) => searchProducts(value),
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
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
            if (cartItems.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    cartItems.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    List<String> categories = ['All', 'Dogs', 'Cats', 'Fish', 'Birds', 'Reptiles'];
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              onPressed: () => updateFilter(categories[index]),
              child: Text(categories[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    List<Product> filteredProducts = products.where((p) {
      return (filter == 'All' || p.category == filter) &&
          (searchQuery.isEmpty || p.name.toLowerCase().contains(searchQuery));
    }).toList();

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
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              product.imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Icon(Icons.shopping_cart, size: 50, color: Colors.grey);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '\$${product.price.toString()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      cartItems.add(product.name);
                    });
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

  void updateFilter(String newFilter) {
    setState(() {
      filter = newFilter;
    });
  }
}
