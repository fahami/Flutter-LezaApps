import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/models/restaurants.dart';
import 'package:resto/provider/restaurants.dart';

class ListofRestaurant extends StatelessWidget {
  const ListofRestaurant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: Consumer<RestaurantProvider>(
        builder: (context, restaurant, _) {
          if (restaurant.state == ResultState.Loading) {
            return SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset('assets/animations/loading.json',
                          width: 200),
                      Text(restaurant.message)
                    ],
                  ),
                ),
              ),
            );
          } else if (restaurant.state == ResultState.HasData) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: restaurant.result.count,
              itemBuilder: (context, index) {
                final Restaurants resto = restaurant.result.restaurants[index];
                return BounceInUp(
                  delay: Duration(milliseconds: 100 * index),
                  child: Card(
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
                                Icon(Icons.star, color: Colors.amber),
                                Text(resto.rating.toString())
                              ],
                            ),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          resto.pictureSmallUrl(),
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
          } else if (restaurant.state == ResultState.NoData) {
            return SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset('assets/animations/empty.json', width: 200),
                      Text(restaurant.message)
                    ],
                  ),
                ),
              ),
            );
          } else if (restaurant.state == ResultState.Error) {
            return SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Lottie.asset('assets/animations/error.json', width: 200),
                      Text(restaurant.message)
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
