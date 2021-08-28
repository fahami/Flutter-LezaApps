import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/components/restaurant_list.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/models/restaurant.dart';
import 'package:resto/provider/restaurants_provider.dart';
import 'package:resto/provider/search_provider.dart';

class Search extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Cari restoran/menu';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(
        apiService: ApiService(),
        query: query,
      ),
      child: Consumer<SearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/loading.json', width: 200),
                    Text(state.message)
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.HasData) {
            final List<Restaurant> suggestions = state.searches.restaurants;
            return Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: query.isEmpty
                          ? Text('')
                          : Text('Menampilkan hasil pencarian "$query"'),
                    ),
                    Expanded(
                      child: RestaurantListBuilder(
                        count: suggestions.length,
                        data: suggestions,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/empty.json', width: 200),
                    Text(state.message)
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/error.json', width: 200),
                    Text(state.message)
                  ],
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/loading.json', width: 200),
                    Text(state.message)
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.HasData) {
            final List<Restaurant> suggestions = query == ''
                ? state.result.restaurants.sublist(0, 3)
                : state.result.restaurants
                    .where(
                      (restaurant) =>
                          restaurant.name.toLowerCase().startsWith(query),
                    )
                    .toList();
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final Restaurant restaurants = suggestions[index];
                return ListTile(
                  onTap: () {
                    Get.toNamed('/restaurantDetail', arguments: restaurants.id);
                    print(restaurants.id);
                  },
                  leading: Icon(Icons.local_restaurant),
                  title: RichText(
                    text: TextSpan(
                      text: restaurants.name.substring(0, query.length),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: restaurants.name.substring(query.length),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/error.json', width: 200),
                    Text(state.message)
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/error.json', width: 200),
                    Text(state.message)
                  ],
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
