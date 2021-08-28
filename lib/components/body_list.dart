import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/provider/restaurants_provider.dart';

import 'restaurant_list.dart';

class BodyList extends StatelessWidget {
  const BodyList({
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
            return RestaurantListBuilder(
              count: restaurant.result.count,
              data: restaurant.result.restaurants,
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
