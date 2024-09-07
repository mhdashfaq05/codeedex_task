import 'dart:convert';
import 'package:codeedex_task/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart'; // To get stored JWT token

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  List<dynamic> _products = [];
  bool _isLoading = true; // To show loading indicator
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products when the screen loads
  }

  Future<void> _fetchProducts() async {
    final String baseUrl = 'https://prethewram.pythonanywhere.com/api/';
    final String endpoint = 'parts_categories/';
    final String url = '$baseUrl$endpoint';

    // Get the stored JWT token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =
        prefs.getString('token'); // Assuming you stored the token as 'token'

    // Ensure the token exists
    if (token == null) {
      setState(() {
        _errorMessage = 'Authentication token not found. Please log in again.';
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Attach the token to the request
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Successful request, parse the JSON response
        setState(() {
          _products = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        // Request failed
        setState(() {
          _errorMessage = 'Failed to fetch products: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (error) {
      // Handle error during request
      setState(() {
        _errorMessage = 'Error fetching products: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products'),actions: [GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LandingScreenPage(),),(route) => false,);
        },
        child: Row(
          children: [
            Text("LogOut",style: TextStyle( fontWeight: FontWeight.w500,fontSize: w*0.04,color: Colors.red),),
            SizedBox(width: w*0.01
              ),
            Icon(Icons.logout_sharp,color: Colors.red,)
          ],
        ),
      )],),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator()) // Show loading while fetching
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage)) // Show error message if any
              : GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    childAspectRatio: 0.8, // Aspect ratio for product cards
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return ProductCard(
                        product:
                            product); // Create a ProductCard widget for each product
                  },
                ),
    );
  }
}

// A widget to display individual products
class ProductCard extends StatelessWidget {
  final dynamic product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.network(
              product['image'] ??
                  'https://via.placeholder.com/150', // Default image if null
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name'] ?? 'Unnamed Product',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${product['price'] ?? 'N/A'}',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
