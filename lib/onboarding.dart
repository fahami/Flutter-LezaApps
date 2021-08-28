import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import 'config/color.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        done: Text('Masuk'),
        onDone: () => Get.toNamed('/login'),
        showSkipButton: true,
        skip: Text('Lewati'),
        next: Icon(Icons.chevron_right),
        color: colorAccent,
        nextColor: colorAccent,
        skipColor: colorAccent,
        dotsDecorator: DotsDecorator(
          activeColor: colorAccent,
          activeSize: Size(22, 12),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        pages: [
          PageViewModel(
            title: 'Cari Restoran Terpopuler',
            body: 'Resto terpopuler selalu menyajikan yang terbaik',
            image: Lottie.asset('assets/animations/find.json'),
          ),
          PageViewModel(
            title: 'Kunjungi Restoran Terbaik',
            body: 'Restoran terdekat tidak kalah mantap!',
            image: Lottie.asset('assets/animations/map.json'),
          ),
          PageViewModel(
            title: 'Simpan ke Favorit',
            body: 'Pastikan kamu tetap update dengan restoran favoritmu',
            image: Lottie.asset('assets/animations/heart.json'),
          )
        ],
      ),
    );
  }
}
