// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
//
// import '../WPage/Warning.dart';
// import '../dashBord/HomeView.dart';
//
// class FetchData extends StatefulWidget {
//   const FetchData({Key? key}) : super(key: key);
//
//   @override
//   _FetchDataState createState() => _FetchDataState();
// }
//
// class _FetchDataState extends State<FetchData> {
//   DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('esp');
//
//   var snapshotValue; // Store the snapshot value
//
//   @override
//   void initState() {
//     super.initState();
//     _listenForChanges(); // Start listening for changes when the widget is initialized
//   }
//
//   void _listenForChanges() {
//     databaseRef.onValue.listen((DatabaseEvent event) {
//       DataSnapshot snapshot = event.snapshot;
//       setState(() {
//         snapshotValue = snapshot.value;
//       });
//       // Optionally navigate to HomeView on each change
//       _navigateToHomeView(snapshotValue);
//     }, onError: (error) {
//       print("Failed to fetch data: $error");
//       // Handle error here
//     });
//   }
//
//   void _navigateToHomeView(dynamic snapshotValue) {
//     if (snapshotValue != null) {
//       // Check if snapshotValue is a Map and get the first value
//       if (snapshotValue is Map) {
//         var GasSensorValue = snapshotValue.values.last;
//
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView(value: GasSensorValue),),);
//
//       } else {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomeView(value: snapshotValue),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // You can return any widget here if needed, this example doesn't use a UI element from FetchData
//     return Container();
//   }
// }
