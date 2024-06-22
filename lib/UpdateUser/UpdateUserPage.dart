import 'package:flutter/material.dart';
import '../LoSi/UserModel.dart';
import 'UpdateController.dart';

class UserProfileUpdatePage extends StatefulWidget {
  final String email;
  final String userName;

  UserProfileUpdatePage({required this.email, required this.userName});

  @override
  _UserProfileUpdatePageState createState() => _UserProfileUpdatePageState();
}

class _UserProfileUpdatePageState extends State<UserProfileUpdatePage> {
  late UserModel _currentUser;
  bool _isLoading = false;
  bool _editMode = false;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userPhone1Controller = TextEditingController();
  TextEditingController _userPhone2Controller = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userFirstNameController = TextEditingController();
  TextEditingController _userLastNameController = TextEditingController();
  TextEditingController _userMaritalStatusController = TextEditingController();
  TextEditingController _nationalIDController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _addressCityController = TextEditingController();
  TextEditingController _addressRegionController = TextEditingController();
  TextEditingController _addressStreetController = TextEditingController();
  TextEditingController _flameSensorController = TextEditingController();
  TextEditingController _gasSensorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate fetching user data from an API or database
      _currentUser = UserModel(
        token: '',
        email: widget.email,
        userName: widget.userName,
      );


      _userNameController.text = _currentUser.userName;
      _userEmailController.text = _currentUser.email;
      _userPhone1Controller.text = "";
      _userPhone2Controller.text = "";
      _userMaritalStatusController.text = "";
      _passwordController.text = "";
      _userFirstNameController.text = "";
      _userLastNameController.text = "";
      _nationalIDController.text = "";
      _genderController.text = "";
      _addressCityController.text = "";
      _addressRegionController.text = "";
      _addressStreetController.text = "";
      _flameSensorController.text = "";
      _gasSensorController.text = "";

    } catch (e) {
      print('Failed to fetch user information: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserInformation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserController userController = UserController();
      await userController.updateUserByEmail(
        email: _userEmailController.text.trim(),
        userName: _userNameController.text.trim(),
        userPhone1: _userPhone1Controller.text.trim(),
        userPhone2: _userPhone2Controller.text.trim(),
        userMaritalStatus: _userMaritalStatusController.text.trim(),
        password: _passwordController.text.trim(),
        firstName: _userFirstNameController.text.trim(),
        lastName: _userLastNameController.text.trim(),
        nationalID: _nationalIDController.text.trim(),
        gender: _genderController.text.trim(),
        addressCity: _addressCityController.text.trim(),
        addressRegion: _addressRegionController.text.trim(),
        addressStreet: _addressStreetController.text.trim(),
        flameSensor: _flameSensorController.text.trim(),
        gasSensor: _gasSensorController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User information updated successfully')),
      );

      setState(() {
        _editMode = false;
      });
    } catch (e) {
      print('Failed to update user information: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user information. Please try again later.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _editMode = true; // Switch to edit mode
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildField('Username', _userNameController),
              _buildField('First Name', _userFirstNameController),
              _buildField('Last Name', _userLastNameController),
              _buildField('Email', _userEmailController),
              _buildField('Password', _passwordController, obscureText: true),
              _buildField('Phone 1', _userPhone1Controller),
              _buildField('Phone 2', _userPhone2Controller),
              _buildField('Marital Status', _userMaritalStatusController),
              _buildField('National ID', _nationalIDController),
              _buildField('Gender', _genderController),
              _buildField('Address City', _addressCityController),
              _buildField('Address Region', _addressRegionController),
              _buildField('Address Street', _addressStreetController),
              _buildField('Flame Sensor Serial Number', _flameSensorController),
              _buildField('Gas Sensor Serial Number', _gasSensorController),
              SizedBox(height: 20),
              _editMode
                  ? Padding(
                    padding: const EdgeInsets.only(right: 30,left: 30),
                    child: ElevatedButton(
                                    onPressed: _updateUserInformation,
                                    child: Text('Update Information',style: TextStyle(color: Colors.white),),
                                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,


                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                                    ),
                                  ),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          enabled: _editMode,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
