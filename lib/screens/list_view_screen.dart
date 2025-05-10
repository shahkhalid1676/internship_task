import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'detail_screen.dart';

class ListViewScreen extends StatelessWidget {
  final List<Map<String, String>> dummyData = [
    {
      "title": "Card 1",
      "subtitle": "Subtitle 1",
      "image": "assets/images/1.jpg",
    },
    {
      "title": "Card 2",
      "subtitle": "Subtitle 2",
      "image": "assets/images/2.jpg",
    },
    {
      "title": "Card 3",
      "subtitle": "Subtitle 3",
      "image": "assets/images/3.jpg",
    },
    {
      "title": "Card 4",
      "subtitle": "Subtitle 4",
      "image": "assets/images/3.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView Example")),
      body: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          final item = dummyData[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(item['image']!, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(item['title']!),
              subtitle: Text(item['subtitle']!),
              onTap: () {
                Get.to(() => DetailScreen(data: item));
              },
            ),
          );
        },
      ),
    );
  }
}
