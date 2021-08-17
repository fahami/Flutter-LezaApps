import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/models/restaurants.dart';
import 'package:resto/provider/restaurants.dart';
import 'package:resto/provider/search.dart';

class Search extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Cari restoran/menu';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Menampilkan hasil pencarian "$query"'),
            Divider(),
            Expanded(
                child: ChangeNotifierProvider(
              create: (_) =>
                  SearchProvider(apiService: ApiService(), query: query),
              child: Consumer<SearchProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(
                        child: Lottie.asset('assets/animations/loading.json'));
                  } else if (state.state == ResultState.HasData) {
                    final List<Restaurants> suggestions =
                        state.searches.restaurants;
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1,
                          child: ListTile(
                              onTap: () {
                                print(suggestions[index]);
                                Get.toNamed('/restaurantDetail',
                                    arguments: suggestions[index].id);
                              },
                              trailing: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.star, color: Colors.amber),
                                        Text(suggestions[index]
                                            .rating
                                            .toString())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      suggestions[index].pictureSmallUrl())),
                              subtitle: Text(suggestions[index].city),
                              title: RichText(
                                text: TextSpan(
                                    text: suggestions[index]
                                        .name
                                        .substring(0, query.length),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: suggestions[index]
                                              .name
                                              .substring(query.length),
                                          style: TextStyle(color: Colors.grey))
                                    ]),
                              )),
                        );
                      },
                    );
                  } else if (state.state == ResultState.NoData) {
                    return Center(
                        child: Lottie.asset('assets/animations/empty.json'));
                  } else if (state.state == ResultState.Error) {
                    print(state.message);
                    return Center(
                        child: Lottie.asset('assets/animations/error.json'));
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ))
          ],
        ),
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
                child: Lottie.asset('assets/animations/loading.json'));
          } else if (state.state == ResultState.HasData) {
            final List<Restaurants> suggestions = query.isEmpty
                ? state.result.restaurants.sublist(0, 3)
                : state.result.restaurants
                    .where((e) => e.name.toLowerCase().startsWith(query))
                    .toList();
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      print(suggestions[index]);
                      Get.toNamed('/restaurantDetail',
                          arguments: suggestions[index].id);
                    },
                    leading: Icon(Icons.local_restaurant),
                    title: RichText(
                      text: TextSpan(
                          text: suggestions[index]
                              .name
                              .substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: suggestions[index]
                                    .name
                                    .substring(query.length),
                                style: TextStyle(color: Colors.grey))
                          ]),
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
      ),
    );
  }
}
