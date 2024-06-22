import 'package:flutter/material.dart';

import 'User.dart';
import 'fetchUser.dart';

class UserProfilePage extends StatefulWidget {
  final String email;

  UserProfilePage({required this.email});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<User?> userFuture;
  bool _isPasswordVisible = false; // State variable to toggle password visibility

  @override
  void initState() {
    super.initState();
    userFuture = getUserByEmail(widget.email);
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      UserController userController = UserController();
      return await userController.getUserByEmail(email);
    } catch (e) {
      print('Failed to fetch user by email: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<User?>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            return user != null ? _buildUserProfile(user) : Center(child: Text('No user data found'));
          } else {
            return Center(child: Text('No user data found'));
          }
        },
      ),
    );
  }

  Widget _buildUserProfile(User user) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          _buildUserInfoCard('Personal Information', [
            _buildUserInfoTile('Username', user.userName),
            _buildUserInfoTile('Email', user.email),
            _buildUserInfoTile('Password', user.password),
            _buildUserInfoTile('First Name', user.firstName),
            _buildUserInfoTile('Last Name', user.lastName),
            _buildUserInfoTile('National ID', user.nationalID),
            _buildUserInfoTile('Gender', user.gender),
            _buildUserInfoTile('Marital Status', user.maritalStatus),
          ]),
          _buildUserInfoCard('Contact Information', [
            _buildUserInfoTile('Phone 1', user.phone1),
            _buildUserInfoTile('Phone 2', user.phone2),
          ]),
          _buildUserInfoCard('Address Information', [
            _buildUserInfoTile('City', user.addressCity),
            _buildUserInfoTile('Region', user.addressRegion),
            _buildUserInfoTile('Street', user.addressStreet),
          ]),
          _buildUserInfoCard('Sensor Information', [
            _buildUserInfoTile('Flame Sensor', user.flameSensor),
            _buildUserInfoTile('Gas Sensor', user.gasSensor.toString()),
          ]),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoTile(String label, String? value) {
    return ListTile(
      title: Text(label),
      subtitle: label == 'Password' ? _buildPasswordSubtitle(value) : Text(value ?? 'N/A'),
    );
  }

  Widget _buildPasswordSubtitle(String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_isPasswordVisible ? value ?? 'N/A' : '••••••••'),
        IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
            });
          },
        ),
      ],
    );
  }
}
