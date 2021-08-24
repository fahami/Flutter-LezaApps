import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:resto/components/search.dart';
import 'components/list_of_restaurant.dart';
import 'config/text_style.dart';

class Home extends StatelessWidget {
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
                      child: CircleAvatar(
                        maxRadius: 25,
                        backgroundImage: AssetImage('assets/img/person.jpeg'),
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
