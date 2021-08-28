import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/config/color.dart';
import 'package:resto/models/restaurant.dart';

class RestaurantListBuilder extends StatelessWidget {
  final int count;
  final List<Restaurant> data;
  const RestaurantListBuilder({
    Key? key,
    required this.count,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: count,
      itemBuilder: (context, index) {
        final Restaurant resto = data[index];
        return BounceInUp(
          delay: Duration(milliseconds: 100 * index),
          child: Card(
            color: colorCard,
            elevation: 0,
            child: ListTile(
              onTap: () => Get.toNamed(
                '/restaurantDetail',
                arguments: resto.id,
              ),
              subtitle: Text(resto.city),
              trailing: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: colorAccent),
                        Text(resto.rating.toString())
                      ],
                    ),
                  ),
                ],
              ),
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  resto.pictureUrl(),
                ),
              ),
              title: Text(
                resto.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
