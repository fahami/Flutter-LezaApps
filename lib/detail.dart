import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/models/restaurant.dart';
import 'package:resto/provider/detail_provider.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'components/content_details.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) =>
          DetailProvider(apiService: ApiService(), id: Get.arguments),
      builder: (context, child) {
        return Consumer<DetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/loading.json', width: 200),
                    Text(state.message)
                  ],
                ),
              );
            } else if (state.state == ResultState.HasData) {
              final Restaurant? restaurant = state.result.restaurant;
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: restaurant!.pictureUrl(),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    child: AppBar(
                      actions: [
                        IconButton(
                          onPressed: () => Share.share(
                            'Yuk pergi ke Restoran ${restaurant.name} yang berlokasi di ${restaurant.city}',
                          ),
                          icon: Icon(Icons.share),
                        ),
                        IconButton(
                          onPressed: () => Get.toNamed('/'),
                          icon: Icon(Icons.home),
                        )
                      ],
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                  SizedBox.expand(
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.5,
                      minChildSize: 0.4,
                      maxChildSize: 0.75,
                      builder: (context, scrollController) {
                        return ContentDetails(
                          restaurant: restaurant,
                          scrollController: scrollController,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state.state == ResultState.NoData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/empty.json', width: 200),
                    Text(state.message)
                  ],
                ),
              );
            } else if (state.state == ResultState.Error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animations/error.json', width: 200),
                    Text(state.message)
                  ],
                ),
              );
            } else
              return Center(child: Text(''));
          },
        );
      },
    ));
  }
}
