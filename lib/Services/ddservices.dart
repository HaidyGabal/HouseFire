import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../Drawer/MyDrawerScreen.dart';
import 'Services_Contr.dart'; // Adjust the import based on your file structure

class DDServices extends StatefulWidget {
  final accessToken;


  const DDServices({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<DDServices> createState() => _DDServicesState();
}

class _DDServicesState extends State<DDServices> {
  late List<dynamic> data = [];
  int? _selectedService;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  late MessController messController;

  @override
  void initState() {
    super.initState();
    messController = MessController(widget.accessToken.token);
    _getData();
  }

  Future<void> _getData() async {
    try {
      final response = await http.get(
        Uri.parse("https://companygas.runasp.net/api/Services"),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load services - Status code: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('Error', 'Failed to load services: $e');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerScreen(userModel: widget.accessToken,),
      appBar: AppBar(

        backgroundColor: Colors.grey.shade400,
        title: Text("Services"),
        toolbarHeight: 100.0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )

        ),


      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("You can send messages to the Gas Company!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              )),
              SizedBox(height: 20,),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Choose the Service',
                ),
                value: _selectedService,
                onChanged: (value) {
                  setState(() {
                    _selectedService = value;
                  });
                },
                items: data.map<DropdownMenuItem<int>>((e) {
                  return DropdownMenuItem<int>(
                    value: e["service_id"] as int,
                    child: Text(e["services_name"] as String),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please choose a service';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                minLines: 4,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your message',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,

                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final serviceName =
                      data.firstWhere((element) => element['service_id'] == _selectedService)['services_name'];
                      await messController.createMessage(
                        feedback_name: _messageController.text,
                        services_name: serviceName,
                      );
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Send Message'),

                          content: Text('Please wait until we contact you'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                      print("Message sent!");
                    } catch (error) {
                      _showErrorDialog('Send', 'Thank you.The company will contact you ');
                    }
                  }
                },
                child: Text('Send Now',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
