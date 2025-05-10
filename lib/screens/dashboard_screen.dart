import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detail_screen.dart';
import 'settings_screen.dart';  // Import the SettingsScreen

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titles = ["Card 1", "Card 2", "Card 3", "Card 4"];
    final subtitles = ["Subtitle 1", "Subtitle 2", "Subtitle 3", "Subtitle 4"];
    final icons = [Icons.star, Icons.favorite, Icons.work, Icons.school];

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to the Settings screen
              Get.to(() => SettingsScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              "Welcome, User!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // PageView for image carousel
            Container(
              height: 200,
              child: PageView(
                children: [
                  Image.asset('assets/images/1.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/2.jpg', fit: BoxFit.cover),
                  Image.asset('assets/images/3.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Cards Section
            Text(
              "Cards Section",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // GridView of cards
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Pass data to the DetailScreen
                      Get.to(() => DetailScreen(
                          data: {
                            "title": titles[index],
                            "subtitle": subtitles[index],
                            "image": 'assets/images/${index + 1}.jpg',
                          }
                      ));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icons[index], size: 50, color: Colors.teal),
                          SizedBox(height: 8),
                          Text(
                            titles[index],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(subtitles[index]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}
