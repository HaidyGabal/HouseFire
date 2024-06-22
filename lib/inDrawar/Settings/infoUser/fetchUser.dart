import 'dart:convert';
import 'package:http/http.dart' as http;
import 'User.dart';

class UserController {
  Future<User> getUserByEmail(String email) async {
    final response = await http.get(
      Uri.parse("https://companygas.runasp.net/api/Users/GetUserByEmail?email=$email"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      print('GetUserByEmail response: $decodedResponse'); // Debug print
      return User.fromJson(decodedResponse);
    } else {
      var decodedResponse = jsonDecode(response.body);
      final errorMessage = decodedResponse['error'] ?? 'Failed to get user by email';
      throw Exception(errorMessage);
    }
  }
}
