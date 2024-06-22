import 'dart:convert';
import 'package:http/http.dart' as http;

class UserController {
  Future<void> updateUserByEmail({
    required String email,
    required String userName,
    required String userPhone1,
    required String userPhone2,
    required String userMaritalStatus,
    required String password,
    required String firstName,
    required String lastName,
    required String nationalID,
    required String gender,
    required String addressCity,
    required String addressRegion,
    required String addressStreet,
    required String flameSensor,
    required String gasSensor,
  }) async {
    final updateData = {
      'email': email,
      'user_name': userName,
      'phone1': userPhone1,
      'phone2': userPhone2,
      'marital_status': userMaritalStatus,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'national_ID': nationalID,
      'gender': gender,
      'address_city': addressCity,
      'address_Region': addressRegion,
      'address_street': addressStreet,
      'flame_sensor': flameSensor,
      'gas_sensor': gasSensor,
    };

    print('Sending update data: $updateData');

    final response = await http.put(
      Uri.parse("https://companygas.runasp.net/api/Users/UpdateUserByEmail?email=$email"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updateData),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 204) {
      // Success case where server returns no content (204)
      print('User information updated successfully');
    } else if (response.statusCode == 200) {
      // Handle if server returns 200 with no content
      print('User information updated successfully (200)');
    } else {
      // Handle error response
      throw Exception('Failed to update user information: ${response.body}');
    }
  }
}
