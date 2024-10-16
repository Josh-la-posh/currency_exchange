import 'package:dio/dio.dart';

class AddressService {
  final Dio _dio = Dio();
  final String _apiKey = 'AIzaSyALj1kekJvTeiUeTQhmq1VAOjUP6_ICBJk';

  Future<String?> getAddressFromPostalCode(String postalCode) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'address': postalCode,
          'key': _apiKey,
        },
      );

      print('The available response code is: ${response.statusCode}');

      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results.isNotEmpty) {
          final formattedAddress = results.first['formatted_address'];
          print('The available response is: $formattedAddress');
          return formattedAddress;
        } else {
          print('No address found for this postal code.');
          return null;
        }
      } else {
        print('Error: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
}