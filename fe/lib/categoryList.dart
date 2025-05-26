import 'package:flutter/material.dart';
import 'package:smilestone/paymentscreen.dart';

class ExploreScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {
      'title': 'Books',
      'imageUrl': 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    },
    {
      'title': 'Electronics',
      'imageUrl': 'https://images.unsplash.com/photo-1514996937319-344454492b37',
    },
    {
      'title': 'Furniture',
      'imageUrl': 'https://images.unsplash.com/photo-1521334884684-d80222895322',
    },
    {
      'title': 'Clothing',
      'imageUrl': 'https://images.unsplash.com/photo-1493666438817-866a91353ca9',
    },
    {
      'title': 'Watches',
      'imageUrl': 'https://images.unsplash.com/photo-1514996937319-344454492b37',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchBar(screenWidth: screenWidth, screenHeight: screenHeight),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Browse by Category',
                style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.02),
              ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryDetailScreen(category: category),
                        ),
                      );
                    },
                    child: BrowseCategoryCard(
                      imageUrl: category['imageUrl']!,
                      title: category['title']!,
                      screenWidth: screenWidth,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------ Search Bar ------------------------

class SearchBar extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const SearchBar({required this.screenWidth, required this.screenHeight});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.screenHeight * 0.01),
        child: Container(
          height: widget.screenHeight * 0.06,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.screenWidth * 0.06),
            border: Border.all(
              color: _isFocused ? Colors.black : Colors.grey,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.04),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.black, size: widget.screenWidth * 0.05),
                SizedBox(width: widget.screenWidth * 0.02),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search for items...',
                      hintStyle: TextStyle(fontSize: widget.screenWidth * 0.045, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------------ Browse Category Card ------------------------

class BrowseCategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double screenWidth;

  const BrowseCategoryCard({
    required this.imageUrl,
    required this.title,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            child: Image.network(
              imageUrl,
              height: screenWidth * 0.2,
              width: screenWidth * 0.2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Icon(Icons.arrow_forward, size: screenWidth * 0.07),
        ],
      ),
    );
  }
}

// ------------------------ Product Card ------------------------

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double screenWidth;

  const ProductCard({
    required this.name,
    required this.imageUrl,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            child: Image.network(
              imageUrl,
              height: screenWidth * 0.2,
              width: screenWidth * 0.2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Icon(Icons.arrow_forward, size: screenWidth * 0.07),
        ],
      ),
    );
  }
}

// ------------------------ Category Detail Screen ------------------------

class CategoryDetailScreen extends StatelessWidget {
  final Map<String, String> category;

  const CategoryDetailScreen({required this.category});

  List<Map<String, String>> getCategoryProducts(String categoryTitle) {
    if (categoryTitle == 'Books') {
      return [
        {
          'name': 'Atomic Habits',
          'imageUrl': 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
          'price': '₹ 180',
          'description': 'A practical guide to building good habits and breaking bad ones.',
          'ownerName': 'James Clear',
          'contact': '9234567890'
        },
        {
          'name': 'Mechanics',
          'imageUrl': 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
          'price': '₹ 150',
          'description': 'Rules for focused success in a distracted world.',
          'ownerName': 'James Clear',
          'contact': '9234567890'
        },
        {
          'name': 'Let us C',
          'imageUrl': 'https://images.unsplash.com/photo-1512820790803-83ca734da794',
          'price': '₹ 280',
          'description': 'A dystopian social science fiction novel and cautionary tale.',
          'ownerName': 'James Clear',
          'contact': '9234567890'
        },
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final products = getCategoryProducts(category['title']!);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(category['title']!)),
      body: ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.04),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: item),
                ),
              );
            },
            child: ProductCard(
              name: item['name']!,
              imageUrl: item['imageUrl']!,
              screenWidth: screenWidth,
            ),
          );
        },
      ),
    );
  }
}

// ------------------------ Product Detail Screen ------------------------

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Product Detail')),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  child: Image.network(
                    product['imageUrl']!,
                    height: screenHeight * 0.1,
                    width: screenWidth*0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width :screenHeight*0.03),

              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            // Product Name
            Text(
              'Product Name:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product['name']!,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                color: Colors.green,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Price
            Text(
              'Price:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product['price']!,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Description
            Text(
              'Description:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product['description'] ?? '',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Owner Name
            Text(
              'Owner Name:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product['ownerName'] ?? 'Not provided',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Contact Number
            Text(
              'Contact Number:',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product['contact'] ?? 'Not provided',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.black,
              ),
            ),

            Spacer(),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.25,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentOptionScreen(product: product),
                    ),
                  );
                },
                child: Text(
                  'Buy Now',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}
