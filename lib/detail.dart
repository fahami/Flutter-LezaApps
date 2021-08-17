import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/constant/enum.dart';
import 'package:resto/provider/detail.dart';
import 'package:get/get.dart';
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
                    child: Lottie.asset('assets/animations/loading.json'));
              } else if (state.state == ResultState.HasData) {
                final restaurant = state.result.restaurant;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(restaurant!.pictureUrl(), fit: BoxFit.cover),
                    SizedBox.expand(
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.5,
                        minChildSize: 0.25,
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
                  child: Lottie.asset('assets/animations/empty.json'),
                );
              } else if (state.state == ResultState.Error) {
                return Center(
                  child: Lottie.asset('assets/animations/error.json'),
                );
              } else
                return Center(child: Text(''));
            },
          );
        },
      ),
    );
  }
}
