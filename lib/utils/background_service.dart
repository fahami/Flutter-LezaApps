import 'dart:isolate';
import 'dart:math';

import 'dart:ui';

import 'package:resto/api/api_service.dart';
import 'package:resto/helpers/notifications_helper.dart';
import 'package:resto/models/restaurant.dart';
import 'package:resto/models/restaurant_lists.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();
  factory BackgroundService() {
    return _service ?? BackgroundService._createObject();
  }
  void initializeService() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    final RestaurantLists result = await ApiService().fetchList();
    final max = result.restaurants.length;
    int random = 0 + Random().nextInt(max - 0);
    final Restaurant recommendation = result.restaurants[random];
    await _notificationHelper.showNotification(
      title: 'Rekomendasi restoran untukmu hari ini!',
      body: '${recommendation.name} di ${recommendation.city}',
      payload: recommendation.id,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
