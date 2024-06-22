import 'dart:convert';

import 'package:http/http.dart'as http;

import 'UserModel.dart';


class UserController {
  Future<UserModel> login({

    required String email,
    required String password,
    String? userName,
    // String? phone1


  }) async {
    final response = await http.post(
      Uri.parse("https://companygas.runasp.net/api/Auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': userName,
        'email': email,
        'password': password,
        // 'Phone':phone1,
      }),
    );

    if (response.statusCode == 200) {
      var jDecode = jsonDecode(response.body);
      return UserModel.fromJson(jDecode);
    } else {
      var jDecode = jsonDecode(response.body);
      final errorMessage = jDecode['error'] ?? 'Failed to login';
      throw Exception(errorMessage);
    }
  }


  Future<UserPostModel> createAccount({
    required String userName,
    int? branchId,
    required String password,
    required String nationalID,
    required String firstName,
    required String lastName,
    required String addressCity,
    required String addressRegion,
    required String addressStreet,
    required String email,
    required String gender,
    String ? flameSensor,
    String? gasSensor,
    String roleName = "User",
    required String phoneNumber,
    required String maritalState,
    required String phoneNumber2,
  }) async {
    final Uri uri = Uri.parse(
        "https://companygas.runasp.net/api/Auth/UserRegister");

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'userName': userName,
        'password': password,
        'nationalID': nationalID,
        'firstName': firstName,
        'lastName': lastName,
        'addressCity': addressCity,
        'addressRegion': addressRegion,
        'addressStreet': addressStreet,
        'email': email,
        'gender': gender,
        'flameSensor': flameSensor,
        'gasSensor': gasSensor,
        'roleName': roleName,
        'phoneNumber': phoneNumber,
        'maritalState': maritalState,
        'phoneNumber2': phoneNumber2,
      }),
    );

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return UserPostModel.fromJson(decodedResponse);
    } else {
      throw Exception('Failed to create account: ${response.body}');
    }
  }

}






class UserPostModel {
  final String message;

  UserPostModel({required this.message});

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(message: json['message']);
  }
  }
