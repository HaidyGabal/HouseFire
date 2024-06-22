// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../Drawer/MyDrawerScreen.dart';
//
// class DealListWidget extends StatefulWidget {
//   @override
//   _DealListWidgetState createState() => _DealListWidgetState();
// }
//
// class _DealListWidgetState extends State<DealListWidget> {
//   List<dynamic> deals = []; // List to store fetched deals
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Fetch data when the widget initializes
//   }
//
//   Future<void> fetchData() async {
//     // Make HTTP GET request
//     final response = await http.get(Uri.parse('http://www.gascompany.somee.com/GetAllDeales'));
//
//     if (response.statusCode == 200) {
//       // If the server returns a 200 OK response, parse the JSON
//       setState(() {
//         deals = json.decode(response.body);
//       });
//     } else {
//       // If the server returns an error response, throw an exception
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Colors.grey.shade400,
//         title: Text("Messages"),
//         toolbarHeight: 100.0,
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25),
//             )
//
//         ),
//
//
//       ),
//       body: ListView.builder(
//         itemCount: deals.length,
//         itemBuilder: (context, index) {
//           final deal = deals[index];
//           return Container(padding: EdgeInsets.all(4.0), // Add padding for spacing
//           margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0), // Add margin for spacing between containers
//           decoration: BoxDecoration(
//           color: Colors.black12, // Add background color for the container
//           borderRadius: BorderRadius.circular(8.0),
//           ),
//
//             child: Column(
//               children: [
//                 ListTile(
//
//                   title: Text(deal['serviceName'] ?? 'No title'), // Use a default value if 'title' is null
//                   subtitle: Text(deal['feedbackIdName'] ?? 'No description'),
//                   // Use a default value if 'description' is null
//                   // You can customize further to handle other properties
//                 ),
//
//               ],
//             ),
//
//           );
//
//         },
//       ),
//       drawer: MyDrawerScreen(),
//
//       //bottomNavigationBar:NavBar(),
//     );
//   }
// }
//
