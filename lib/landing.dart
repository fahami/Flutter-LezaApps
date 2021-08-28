import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/components/search.dart';
import 'package:resto/config/color.dart';
import 'package:resto/helpers/notifications_helper.dart';
import 'components/body_list.dart';
import 'config/text_style.dart';

class Landing extends StatelessWidget {
  final NotificationHelper notificationHelper = NotificationHelper();
  final User? user = FirebaseAuth.instance.currentUser;
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
                          Hero(
                            tag: 'profileHero',
                            child: CircleAvatar(
                                maxRadius: 25,
                                backgroundImage: NetworkImage(user!.photoURL ??
                                    'https://karyasa.my.id/users.png')),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Get.toNamed('/favorite'),
                                icon: Icon(Icons.favorite),
                              ),
                              IconButton(
                                onPressed: () => Get.toNamed('/settings'),
                                icon: Icon(Icons.settings),
                              )
                            ],
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
                            Text(
                                "Hello ${user!.displayName ?? 'Pelanggan Baru'}",
                                style: heading1),
                            Text("Mau makan apa nih?", style: heading1),
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
                                color: colorAccent,
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
                child: BodyList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
