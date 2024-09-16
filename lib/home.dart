import 'package:flutter/material.dart';
import 'navbar.dart'; // Assuming this contains the BottomNavBar content

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200, // Search bar background color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    // Handle search input
                    print("Search: $value");
                  },
                ),
              ),
            ],
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notification click
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Cart screen
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Profile screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Settings screen
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Top Banner Section
          Container(
            height: 250,
            padding: EdgeInsets.all(10.0), // Add padding around the container
            child: ListView(
              scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
              padding: EdgeInsets.zero, // No padding around the list for a cleaner look
              children: [
                BuildClickableCard(context, "Realme P2 pro", "images/3.png", 'Redmi Page', "14% Off"),
                SizedBox(width: 10),
                BuildClickableCard(context, "Redmi Note 7S", "images/2.png", 'Samsung Page', "20% Off"),
                SizedBox(width: 10),
                BuildClickableCard(context, "Infinix hot 50", "images/6.png", 'iPhone Page', "10% Off"),
              ],
            ),
          ),
          SizedBox(height: 20),
          // KYC Box with updated decoration
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Color(0xFF7F87FF), Color(0xFF2E54FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "KYC Pending",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "You need to provide the required documents for your account activation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Handle KYC Click
                    print('KYC Clicked');
                  },
                  child: Text(
                    "Click Here",
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Section with Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildCategoryIcon('Mobile', Icons.phone_android, Colors.blue),
              buildCategoryIcon('Laptop', Icons.laptop, Colors.green),
              buildCategoryIcon('Camera', Icons.camera_alt, Colors.pinkAccent),
              buildCategoryIcon('LED', Icons.lightbulb_outline, Colors.orange),
            ],
          ),
          SizedBox(height: 20),
          // Exclusive Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFEBF7FF), // Similar background color to the image
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EXCLUSIVE FOR YOU',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_forward), // Arrow icon
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 250, // Adjust the height for horizontal scrolling
                  child: ListView(
                    scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                    padding: EdgeInsets.all(8.0), // Add padding around the list
                    children: [
                      buildClickableCard(context, "Nokia 8.1", "images/8.png", 'Nokia Page', "32% Off"),
                      SizedBox(width: 10), // Use width instead of height for horizontal spacing
                      buildClickableCard(context, "Redmi Phone", "images/9.png", 'Redmi Page', "14% Off"),
                      SizedBox(width: 10),
                      // Add more cards as needed
                      buildClickableCard(context, "iPhone 12", "images/10.png", 'iPhone Page', "10% Off"),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(), // Make sure BottomNavBar is called here as well
    );
  }

  Widget buildCategoryIcon(String label, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, size: 30, color: color),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget buildClickableCard(BuildContext context, String title, String imagePath, String routeName, String discount) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page on image click
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(title: title)),
        );
      },
      child: Container(// Full width

        padding: EdgeInsets.all(8), // Padding around the container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2), // Shadow effect
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(imagePath, height: 150, fit: BoxFit.cover),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      discount,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }



  Widget BuildClickableCard(BuildContext context, String title, String imagePath, String routeName, String discount) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page on image click
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(title: title)),
        );
      },
      child: Container(// Full width
        width: 470,
        padding: EdgeInsets.all(8), // Padding around the container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2), // Shadow effect
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(imagePath, height: 170, fit: BoxFit.cover),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      discount,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}

class DetailScreen extends StatelessWidget {
  final String title;

  DetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('$title Details Page'),
      ),
    );
  }
}
