import 'package:flutter/material.dart';
import '../models/product.dart'; // Ensure the path to the Product model is correct
import 'product_detail_page.dart';
import 'cart_page.dart';
import '../../ApiHandler.dart'; // Ensure this path matches your project structure

class PetShopPage extends StatefulWidget {
  const PetShopPage({Key? key}) : super(key: key);

  @override
  State<PetShopPage> createState() => _PetShopPageState();
}

class _PetShopPageState extends State<PetShopPage> {
  List<String> cartItems = [];
  List<Product> products = [];
  String filter = 'All';
  String searchQuery = '';
  final ApiHandler apiHandler = ApiHandler(); // Adjust this instantiation if your ApiHandler requires parameters

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      var fetchedProducts = await apiHandler.getAllProducts(); // Make sure this method exists and is correctly implemented in your ApiHandler
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  void updateFilter(String newFilter) {
    setState(() {
      filter = newFilter;
    });
    fetchProducts(); // Refetch products based on the new filter
  }

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
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: searchProducts,
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildFilterButtons(),
            SizedBox(height: 20),
            _buildProductList(),
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
        child: Icon(Icons.shopping_cart),
      ),
    );
  }


  Widget _buildFilterButtons() {
    List<String> categories = ['All', 'dogs', 'cats', 'fish', 'birds', 'reptiles'];
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              onPressed: () => updateFilter(categories[index]),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              child: Text(categories[index]),
            ),
          );
        },
      ),
    );
  }


  Widget _buildProductList() {
    // This method filters the products based on the current filter and search query
    List<Product> filteredProducts = products.where((product) {
      bool matchesFilter = filter == 'All' || product.petGenre == filter;
      bool matchesSearch = searchQuery.isEmpty || product.name!.toLowerCase().contains(searchQuery);
      return matchesFilter && matchesSearch;
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
            child: product.image != null ? Image.memory(
              product.image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/placeholder.png');  // Ensure you have a 'placeholder.png' in your assets
              },
            ) : Image.asset(
              'assets/placeholder.png',  // Provide a local placeholder if no image is available
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.name ?? "Unnamed Product",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  product.description ?? "No description available.",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      cartItems.add(product.name!);  // Ensure 'name' is not null before adding
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
}
