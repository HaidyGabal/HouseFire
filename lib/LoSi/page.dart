
import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.dart';

class page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            // we will give media query height
            // double.infinity make it big as my parent allows
            // while MediaQuery make it big as per the screen
        
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              // even space distribution
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
        
                      ),
        
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Welcome to our application. Please login to enjoy our services ☺️",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
        
                      ),)
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Mobile encryption-pana.png")
                      )
                  ),
                ),
        
                Column(
                  children: <Widget>[
                    // the login button
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        
                      },
                      // defining the shape
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    ),
                    // creating the signup button
                    SizedBox(height:15),
                    Container(
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));

                        },

                        color: Color(0xFFFF8000),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),

                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),
                        ),
                      ),
                    )
        
                  ],
                )
        
        
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
