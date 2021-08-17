import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:resto/models/restaurant.dart';

class CustomerReviews extends StatelessWidget {
  const CustomerReviews({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: restaurant.customerReviews.length,
      itemBuilder: (context, index) {
        final reviews = restaurant.customerReviews[index];
        return FadeInUp(
          child: ListTile(
            leading: Icon(Icons.rate_review),
            subtitle: Text(reviews.review),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      reviews.name,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    )),
                Expanded(
                  flex: 1,
                  child: Text(
                    reviews.date,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
