import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, String> data;


  DetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(data['image']!, width: 200, height: 200, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              data['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(data['subtitle']!),
          ],
        ),
      ),
    );
  }
}
