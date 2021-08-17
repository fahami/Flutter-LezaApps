import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/provider/restaurants.dart';

class ListofRestaurant extends StatelessWidget {
  const ListofRestaurant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: Expanded(child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
                child: Lottie.asset('assets/animations/loading.json'));
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.result.count,
              itemBuilder: (context, index) {
                final resto = state.result.restaurants[index];
                return BounceInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: Card(
                      elevation: 0,
                      child: ListTile(
                          onTap: () => Get.toNamed('/restaurantDetail',
                              arguments: resto.id),
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
                              backgroundImage:
                                  NetworkImage(resto.pictureUrl())),
                          title: Text(
                            resto.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ));
              },
            );
          } else if (state.state == ResultState.NoData) {
            return Center(child: Lottie.asset('assets/animations/empty.json'));
          } else if (state.state == ResultState.Error) {
            print(state.message);
            return Center(child: Lottie.asset('assets/animations/error.json'));
          } else {
            return Center(child: Text(''));
          }
        },
      )),
    );
  }
}
