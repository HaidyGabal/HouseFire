// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'Bills_Model.dart';
//
//
//
// class BillController {
//   Future<BillsModel> getBillsByUserId() async {
//     final response = await http.get(
//       Uri.parse('https://gaswebsite.runasp.net/api/Bills/GetBillByEmail?email=${BillsModel}'),
//     );
//
//     if (response.statusCode == 200) {
//       var responseBody = response.body;
//       print('Bills response body: $responseBody'); // Print response body for debugging
//
//       var jDecode = jsonDecode(responseBody) as List;
//       print('Decoded JSON: $jDecode'); // Print decoded JSON for debugging
//
//       return BillModel.fromJson(jDecode.cast<Map<String, dynamic>>());
//     } else {
//       throw Exception('Failed to load bills: ${response.statusCode}');
//     }
//   }
// }
