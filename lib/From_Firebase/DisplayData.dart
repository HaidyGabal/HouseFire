import 'package:flutter/material.dart';

class DisplayDataPage extends StatelessWidget {
  final dynamic data;

  const DisplayDataPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
      ),
      body: Center(
        child: Text(
          data != null ? data.toString() : 'No data available',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
