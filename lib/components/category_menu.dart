import 'package:flutter/material.dart';
import 'package:resto/config/color.dart';
import 'package:resto/models/restaurant.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: restaurant.categories!
          .map(
            (resto) => Container(
              margin: EdgeInsets.only(right: 4),
              child: Chip(
                backgroundColor: colorAccent.withOpacity(0.2),
                label: Text(resto.name),
              ),
            ),
          )
          .toList()
          .cast(),
    );
  }
}
