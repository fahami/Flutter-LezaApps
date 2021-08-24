import 'package:flutter/material.dart';
import 'package:resto/models/restaurant.dart';

class DrinksMenu extends StatelessWidget {
  const DrinksMenu({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: restaurant.menus.drinks
          .map(
            (drink) => Container(
              margin: EdgeInsets.only(right: 4),
              child: Chip(
                backgroundColor: Colors.red.withOpacity(0.2),
                label: Text(drink.name),
              ),
            ),
          )
          .toList()
          .cast(),
    );
  }
}
