import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/components/favorite_header.dart';
import 'package:resto/config/color.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/models/restaurant.dart';
import 'package:resto/provider/favorite_provider.dart';
import 'package:resto/helpers/database_helper.dart';

class FavoriteRestaurant extends StatelessWidget {
  const FavoriteRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.back(),
        backgroundColor: colorAccent,
        child: Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: FavoriteHeader(maxExtent: 180, minExtent: 80),
          ),
          SliverFillRemaining(
            child: ChangeNotifierProvider(
              create: (_) => FavoriteProvider(databaseHelper: DatabaseHelper()),
              child: Consumer<FavoriteProvider>(
                builder: (context, provider, _) {
                  if (provider.state == ResultState.Loading) {
                    return Center(
                      child: Text('Sedang memuat'),
                    );
                  } else if (provider.state == ResultState.HasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.results.length,
                      itemBuilder: (context, index) {
                        final Restaurant result = provider.results[index];
                        return Dismissible(
                          background: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          key: Key(result.id),
                          onDismissed: (direction) =>
                              provider.removeFavorite(result.id),
                          child: ListTile(
                            onTap: () => Get.toNamed(
                              '/restaurantDetail',
                              arguments: result.id,
                            ),
                            subtitle: Text(result.city),
                            trailing: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star, color: colorAccent),
                                      Text(result.rating.toString())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                result.pictureUrl(),
                              ),
                            ),
                            title: Text(
                              result.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (provider.state == ResultState.NoData) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset('assets/animations/empty.json',
                              width: 200),
                          Text(provider.message)
                        ],
                      ),
                    );
                  } else if (provider.state == ResultState.Error) {
                    return Center(
                      child: Text('Database bermasalah'),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
