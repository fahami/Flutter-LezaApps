import 'package:flutter_test/flutter_test.dart';
import 'package:resto/api/api_service.dart';

void main() {
  group('Testing API Service', () {
    final apiService = ApiService();

    test('Get first restaurant name', () async {
      // arrange
      var restaurantName = 'Melting Pot';
      // act
      final act = await apiService.fetchList();
      // assert
      var result = act.restaurants[0].name == restaurantName;
      expect(result, true);
    });
    test('Success parse json', () async {
      // arrange
      var status = 'success';
      // act
      final act = await apiService.fetchList();
      // assert
      expect(act.message, status);
    });
  });
}
