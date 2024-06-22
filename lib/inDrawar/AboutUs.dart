import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 80.0,
                        child: Container(
                          // Use BoxDecoration to set the background image
                            decoration: BoxDecoration(
                              image: DecorationImage(


                                image: AssetImage('assets/splash - Copy.png'),
                                fit: BoxFit.fill, // Cover the entire area
                              ),
                            ),)

                      ),

                      SizedBox(height: 20.0),
                      // Text(
                      //   'House Fire',
                      //   style: TextStyle(
                      //     fontSize: 28.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(height: 10.0),
                      Text(
                        'The primary objective of this project is to develop a mobile application named "House Fire" using the Flutter framework. The app aims to provide users with real-time monitoring and alerts related to gas leaks and consumption rates. Key features include user onboarding, authentication, gas and flame sensor readings, warning notifications, service requests to gas companies, bill management, and customizable app settings. The goal is to create a user-friendly interface that ensures safety and convenience for users',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // Your main content here
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [

              Text(
                'Connect with us:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Container(


                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20.0,
                  children: [



                    SocialIcon(
                      iconPath: 'assets/facebook (1).png',
                      onPressed: () {
                        launchURL('https://www.facebook.com/example'); // Replace with your Facebook URL
                      },
                    ),
                    SocialIcon(
                      iconPath: 'assets/twitter.png',
                      onPressed: () {
                        launchURL('https://twitter.com/example'); // Replace with your Twitter URL
                      },
                    ),
                    SocialIcon(
                      iconPath: 'assets/linkedin.png',
                      onPressed: () {
                        launchURL('https://www.linkedin.com/company/example'); // Replace with your LinkedIn URL
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SocialIcon extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;

  const SocialIcon({
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        iconPath,
        width: 40.0, // Adjust icon size as needed
        height: 40.0,
      ),
      onPressed: onPressed,
    );
  }
}
