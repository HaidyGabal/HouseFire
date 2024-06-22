import 'package:flutter/material.dart';

import 'controller.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressCityController = TextEditingController();
  final TextEditingController addressRegionController = TextEditingController();
  final TextEditingController addressStreetController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userGenderController = TextEditingController();
  final TextEditingController userFlameSensorController = TextEditingController();
  final TextEditingController userGasSensorController = TextEditingController();
  final TextEditingController roleNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController maritalStateController = TextEditingController();
  final TextEditingController phoneNumber2Controller = TextEditingController();

  final UserController userController = UserController();

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Text headers and form fields
              const Text(
                "Create Accounts",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const Text(
                "Please fill in your details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildTextField(userNameController, "UserName", "User Name"),
              _buildTextField(firstNameController, "FirstName", "First Name"),
              _buildTextField(lastNameController, "LastName", "Last Name"),
              _buildTextField(userEmailController, "Email", "Email"),
              _buildPasswordField(passwordController, "Password", "Password"),
              _buildPasswordField(confirmPasswordController, "Confirm Password", "Confirm Password"),
              _buildTextField(nationalIDController, "NationalID", "National ID"),
              _buildTextField(addressCityController, "AddressCity", "Address City"),
              _buildTextField(addressRegionController, "AddressRegion", "Address Region"),
              _buildTextField(addressStreetController, "AddressStreet", "Address Street"),
              _buildTextField(userGenderController, "Gender", "Gender"),
              _buildTextField(maritalStateController, "MaritalState", "Marital State"),
              _buildTextField(phoneNumberController, "PhoneNumber", "Phone Number"),
              _buildTextField(phoneNumber2Controller, "PhoneNumber2", "Phone Number 2"),
              _buildTextField(userFlameSensorController, "FlameSensor", "Flame Sensor"),
              _buildTextField(userGasSensorController, "GasSensor", "Gas Sensor"),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text != confirmPasswordController.text) {
                          _showAlertDialog(context, "Passwords do not match");
                          return;
                        }
                        try {
                          var response = await userController.createAccount(
                            userName: userNameController.text,
                            password: passwordController.text,
                            nationalID: nationalIDController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            addressCity: addressCityController.text,
                            addressRegion: addressRegionController.text,
                            addressStreet: addressStreetController.text,
                            email: userEmailController.text,
                            gender: userGenderController.text,
                            flameSensor: userFlameSensorController.text,
                            gasSensor: userGasSensorController.text,
                            phoneNumber: phoneNumberController.text,
                            maritalState: maritalStateController.text,
                            phoneNumber2: phoneNumber2Controller.text,
                          );

                          // Check if the account creation was successful
                          if (response.message == "User registered successfully!") {
                            _showAlertDialog(context, "Account created successfully");
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          } else {
                            // If the server returns a message other than success
                            _showAlertDialog(context, "Failed to create account: ${response.message}");
                          }
                        } catch (error) {
                          // Catch any exceptions that occur during account creation
                          _showAlertDialog(context, "Failed to create account: $error");
                        }
                      }
                    },
                    color: Color(0xFFFF8000),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("I have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, String labelText,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
        ),
        validator: (value) =>
        value!.isEmpty ? "$labelText field required" : null,
        obscureText: obscureText,
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller, String hintText, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        validator: (value) =>
        value!.isEmpty ? "$labelText field required" : null,
        obscureText: !_passwordVisible,
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Registration"),
          content: Text(
            message,
            style: const TextStyle(color: Colors.green),
          ),
          actions: [
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
