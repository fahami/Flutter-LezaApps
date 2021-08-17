import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String name;
  final String location;

  const ShareButton({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      shape: CircleBorder(),
      onPressed: () => Share.share(
          'Yuk pergi ke Restoran $name yang berlokasi di $location'),
      child: Column(
        children: [Icon(Icons.share, color: Colors.blue), Text('Share')],
      ),
    );
  }
}
