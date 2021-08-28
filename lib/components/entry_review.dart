import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto/api/api_service.dart';
import 'package:resto/config/color.dart';
import 'package:resto/config/text_style.dart';
import 'package:resto/models/restaurant.dart';

class EntryReview extends StatelessWidget {
  const EntryReview({
    Key? key,
    required this.restaurant,
    required this.nameController,
    required this.reviewController,
  }) : super(key: key);

  final Restaurant restaurant;
  final TextEditingController nameController;
  final TextEditingController reviewController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Beri ulasan untuk ${restaurant.name}",
            style: heading3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Nama",
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.person,
                  color: colorAccent,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              maxLines: 5,
              controller: reviewController,
              decoration: InputDecoration(
                hintText: "Ulasan...",
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.reviews,
                  color: colorAccent,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
                label: Text('Batal'),
              ),
              TextButton.icon(
                onPressed: () async {
                  final req = await ApiService().writeReview(
                    reviewController.text,
                    nameController.text,
                    restaurant.id,
                  );
                  if (req.message == "success") {
                    Get.offNamed('/review', arguments: restaurant);
                  } else {
                    print("Gagal tulis review");
                  }
                },
                icon: Icon(Icons.send),
                label: Text('Kirim'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
