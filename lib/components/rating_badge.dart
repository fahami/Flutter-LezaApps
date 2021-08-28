import 'package:flutter/material.dart';
import 'package:resto/config/color.dart';
import 'package:resto/models/restaurant.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: colorAccent[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: colorAccent,
            size: 16,
          ),
          SizedBox(width: 2),
          RichText(
            text: TextSpan(
              style: TextStyle(color: colorHighlightTitle, fontSize: 12),
              children: [
                TextSpan(text: restaurant.rating.toString()),
                TextSpan(
                  style: TextStyle(fontStyle: FontStyle.italic),
                  text: ' (${restaurant.customerReviews!.length} ulasan)',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
