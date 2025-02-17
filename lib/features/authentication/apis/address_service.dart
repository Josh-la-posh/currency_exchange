import 'package:dio/dio.dart';

class AddressService {
  final Dio _dio = Dio();
  final String _apiKey = 'AIzaSyALj1kekJvTeiUeTQhmq1VAOjUP6_ICBJk';

  Future<List?> getAddressFromPostalCode(String postalCode, {required CancelToken cancelToken}) async {
    try {
      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/geocode/json',
          queryParameters: {
            'address': postalCode,
            'key': _apiKey,
          },
          cancelToken: cancelToken
      );

      print('The available response code is: ${response.statusCode}');

      if (response.statusCode == 200) {
        final results = response.data['results'];
        if (results.isNotEmpty) {
          final formattedAddress = results.first['address_components'];
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