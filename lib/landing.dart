import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'components/list_of_restaurant.dart';
import 'config/text_style.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeInRight(
                      child: CircleAvatar(
                        maxRadius: 25,
                        backgroundImage: AssetImage('assets/img/person.jpeg'),
                      ),
                    ),
                  ],
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
                      // onTap: () => showSearch(
                      //     context: context, delegate: SearchDrawer()),
                      decoration: InputDecoration(
                          hintText: "Cari restoran",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ListofRestaurant()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
