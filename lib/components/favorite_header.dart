import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto/config/color.dart';

class FavoriteHeader implements SliverPersistentHeaderDelegate {
  FavoriteHeader({required this.minExtent, required this.maxExtent});
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/img/restaurant.jpeg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorAccent.withOpacity(0.2), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 40,
          child: Text(
            'Restoran Favorit',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800,
              color: Colors.black.withOpacity(parallax(shrinkOffset)),
              fontSize: 24,
            ),
          ),
        ),
        Positioned(
          left: -24,
          right: 16,
          bottom: 0,
          child: TextButton.icon(
            onPressed: null,
            icon: Icon(Icons.info),
            label: Text('Tambahkan favorit dari halaman restoran'),
          ),
        )
      ],
    );
  }

  double parallax(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  TickerProvider? get vsync => null;
}
