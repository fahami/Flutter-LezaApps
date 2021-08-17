import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:resto/config/color.dart';
import 'package:resto/config/text_style.dart';
import 'package:resto/models/restaurant.dart';
import 'customer_reviews.dart';
import 'drinks_menu.dart';
import 'foods_menu.dart';
import 'rating_badge.dart';
import 'share_button.dart';

class ContentDetails extends StatelessWidget {
  const ContentDetails({
    Key? key,
    required this.restaurant,
    required this.scrollController,
  }) : super(key: key);

  final Restaurant restaurant;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          restaurant.name,
                          style: heroText,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ShareButton(
                          location: restaurant.address,
                          name: restaurant.name,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  FadeIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Colors.amber,
                                size: 16,
                              ),
                              SizedBox(width: 2),
                              Text(
                                restaurant.address,
                                style: TextStyle(
                                    color: colorHighlightTitle, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        RatingBadge(restaurant: restaurant),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  FadeInDown(
                    child: Text(
                      'Deskripsi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  BounceInDown(
                    child: ReadMoreText(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black),
                      moreStyle: TextStyle(color: Colors.amber),
                      lessStyle: TextStyle(color: Colors.amber),
                      trimCollapsedText: 'Lebih lanjut',
                      trimExpandedText: 'Tutup',
                      trimLines: 3,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Minuman',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DrinksMenu(restaurant: restaurant),
                  SizedBox(height: 16),
                  Text(
                    'Makanan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FoodsMenu(restaurant: restaurant),
                  SizedBox(height: 16),
                  Text(
                    'Ulasan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CustomerReviews(restaurant: restaurant),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
