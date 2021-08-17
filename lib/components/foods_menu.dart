import 'package:flutter/material.dart';
import 'package:resto/models/restaurant.dart';

class FoodsMenu extends StatelessWidget {
  const FoodsMenu({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: restaurant.menus.foods
          .map(
            (e) => Container(
              margin: EdgeInsets.only(right: 4),
              child: Chip(
                backgroundColor: Colors.amber.withOpacity(0.2),
                label: Text(e.name),
              ),
            ),
          )
          .toList()
          .cast(),
    );
  }
}
