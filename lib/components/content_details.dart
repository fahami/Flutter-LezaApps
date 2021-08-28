import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:resto/components/category_menu.dart';
import 'package:resto/config/color.dart';
import 'package:resto/config/text_style.dart';
import 'package:resto/models/restaurant.dart';
import 'package:resto/provider/favorite_provider.dart';
import 'package:resto/helpers/database_helper.dart';
import 'customer_reviews.dart';
import 'drinks_menu.dart';
import 'entry_review.dart';
import 'foods_menu.dart';
import 'rating_badge.dart';

class ContentDetails extends StatelessWidget {
  ContentDetails({
    Key? key,
    required this.restaurant,
    required this.scrollController,
  }) : super(key: key);

  final Restaurant restaurant;
  final ScrollController scrollController;
  final reviewController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
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
                          style: heading1,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: ChangeNotifierProvider(
                            create: (_) => FavoriteProvider(
                                databaseHelper: DatabaseHelper()),
                            child: Consumer<FavoriteProvider>(
                              builder: (context, favorite, child) {
                                return FutureBuilder(
                                  future: favorite.checkFavorite(restaurant.id),
                                  builder: (context, snapshot) {
                                    final favorited = snapshot.data ?? false;
                                    return MaterialButton(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            color: favorited == true
                                                ? Colors.red
                                                : Colors.blue,
                                          ),
                                          Text('Favorit')
                                        ],
                                      ),
                                      onPressed: () {
                                        favorited == true
                                            ? favorite
                                                .removeFavorite(restaurant.id)
                                            : favorite.addFavorite(restaurant);
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: MaterialButton(
                            child: Column(
                              children: [
                                Icon(Icons.rate_review, color: Colors.blue),
                                Text("Review")
                              ],
                            ),
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder: (context) {
                                return EntryReview(
                                  restaurant: restaurant,
                                  nameController: nameController,
                                  reviewController: reviewController,
                                );
                              },
                            ),
                            shape: CircleBorder(),
                          ))
                    ],
                  ),
                  SizedBox(height: 8),
                  FadeIn(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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
                                Icons.location_city,
                                color: colorAccent,
                                size: 16,
                              ),
                              SizedBox(width: 2),
                              Text(
                                restaurant.city,
                                style: TextStyle(
                                  color: colorHighlightTitle,
                                  fontSize: 12,
                                ),
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
                      moreStyle: TextStyle(color: colorAccent),
                      lessStyle: TextStyle(color: colorAccent),
                      trimCollapsedText: 'Lebih lanjut',
                      trimExpandedText: 'Tutup',
                      trimLines: 3,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Kategori',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CategoryMenu(restaurant: restaurant),
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
                  ListCustomerReviews(restaurant: restaurant),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
