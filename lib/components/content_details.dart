import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/components/category_menu.dart';
import 'package:resto/config/color.dart';
import 'package:resto/config/text_style.dart';
import 'package:resto/models/restaurant.dart';
import 'customer_reviews.dart';
import 'drinks_menu.dart';
import 'foods_menu.dart';
import 'rating_badge.dart';
import 'share_button.dart';
import 'package:get/get.dart';

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
                                      top: Radius.circular(16))),
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 16,
                                      left: 16,
                                      right: 16,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          "Beri ulasan untuk ${restaurant.name}",
                                          style: titleFoodDetail,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                      SizedBox(height: 16),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: TextField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                              hintText: "Nama",
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: Colors.amber,
                                              ),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: TextField(
                                          maxLines: 5,
                                          controller: reviewController,
                                          decoration: InputDecoration(
                                              hintText: "Ulasan...",
                                              prefixIcon: Icon(
                                                Icons.reviews,
                                                color: Colors.amber,
                                              ),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              icon: Icon(Icons.close),
                                              label: Text('Batal')),
                                          TextButton.icon(
                                              onPressed: () async {
                                                final req = await ApiService()
                                                    .writeReview(
                                                        reviewController.text,
                                                        nameController.text,
                                                        restaurant.id);
                                                if (req.message == "success") {
                                                  Get.offNamed('/review',
                                                      arguments: restaurant);
                                                } else {
                                                  print("Gagal tulis review");
                                                }
                                              },
                                              icon: Icon(Icons.send),
                                              label: Text('Kirim')),
                                        ],
                                      )
                                    ],
                                  ),
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
