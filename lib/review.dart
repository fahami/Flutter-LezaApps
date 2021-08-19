import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:resto/config/text_style.dart';
import 'package:resto/models/restaurant.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final Restaurant data = Get.arguments;
  @override
  void initState() {
    runTimer();
    super.initState();
  }

  void runTimer() {
    Timer(Duration(seconds: 5), () {
      Get.offAllNamed('/restaurantDetail', arguments: data.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/review.json'),
              SizedBox(height: 8),
              Text(
                "Terima kasih telah memberikan review kepada restoran " +
                    data.name,
                style: highlightTitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text('Anda akan diarahkan kembali dalam 5 detik'),
              SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    Get.offAllNamed('/restaurantDetail', arguments: data.id),
                child: Text(
                  "Kembali",
                  style: TextStyle(color: Colors.amber),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
