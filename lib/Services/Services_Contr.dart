import 'dart:convert';
import 'package:http/http.dart' as http;
import 'MessPostModel.dart';

class MessController {
  final String accessToken;

  MessController(this.accessToken);

  Future<MessPostModel> createMessage({

    required String feedback_name,
    required String services_name,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("https://companygas.runasp.net/DTO"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Use the Bearer token here
        },
        body: jsonEncode(<String, dynamic>{

          'feedback_name': feedback_name,
          'services_name': services_name,
        }),
      );

      if (response.statusCode == 200) {
        try {
          var jsonDecoded = jsonDecode(response.body);
          return MessPostModel.fromJson(jsonDecoded);
        } catch (e) {
          print('Exception during JSON decoding: $e');
          print('Response body: ${response.body}');
          throw Exception('Failed to parse response');
        }
      } else if (response.statusCode == 400) {
        print('Response body: ${response.body}');
        throw Exception('Bad Request: ${response.body}');
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Check your API key or token.');
      } else {
        print('Failed to create message - Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create message - Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during createMessage: $e');
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
