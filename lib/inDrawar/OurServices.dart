import 'package:flutter/material.dart';

class FireHousePage extends StatefulWidget {
  @override
  _FireHousePageState createState() => _FireHousePageState();
}

class _FireHousePageState extends State<FireHousePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _sectionTitle('Primary Objective:'),
                SizedBox(height: 8),
                _sectionText(
                  'Develop a mobile application named "House Fire". '
                      'The app aims to provide users with real-time monitoring '
                      'and alerts related to gas leaks and consumption rates.',
                ),
                SizedBox(height: 16),
                _sectionTitle('Key Features:'),
                SizedBox(height: 8),
                _sectionText(
                  '• Authentication\n'
                      '• Gas and flame sensor readings\n'
                      '• Warning notifications\n'
                      '• Service requests to gas companies\n'
                      '• Bill management\n'
                      '• Customizable app settings',
                ),
                SizedBox(height: 16),
                _sectionTitle('Goal of House Fire:'),
                SizedBox(height: 8),
                _sectionText(
                  'The goal is to create a user-friendly interface that '
                      'ensures safety and convenience for users.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          height: 2.4,

        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
