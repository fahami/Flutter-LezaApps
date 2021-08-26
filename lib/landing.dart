import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resto/components/search.dart';
import 'package:resto/helpers/notifications_helper.dart';
import 'package:resto/provider/scheduling_provider.dart';
import 'components/list_of_restaurant.dart';
import 'config/text_style.dart';

class Home extends StatelessWidget {
  final NotificationHelper notificationHelper = NotificationHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInRight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundImage:
                                AssetImage('assets/img/person.jpeg'),
                          ),
                          ChangeNotifierProvider<SchedulingProvider>(
                            create: (_) => SchedulingProvider(),
                            child: Consumer<SchedulingProvider>(
                              builder: (context, scheduled, _) {
                                return Switch.adaptive(
                                  value: scheduled.isScheduled,
                                  onChanged: (value) {
                                    scheduled.scheduledRecommendation(value);
                                  },
                                );
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () => Get.toNamed('/favorite'),
                            icon: Icon(Icons.favorite),
                          )
                        ],
                      ),
                    ),
                    FadeInLeftBig(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hai Fahmi!", style: heroText),
                            Text("Mau makan apa nih?", style: heroText),
                          ],
                        ),
                      ),
                    ),
                    FadeInUp(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(16)),
                        child: TextField(
                          readOnly: true,
                          onTap: () => showSearch(
                            context: context,
                            delegate: Search(),
                          ),
                          decoration: InputDecoration(
                              hintText: "Cari restoran/menu",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.amber,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              Expanded(
                child: ListofRestaurant(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
