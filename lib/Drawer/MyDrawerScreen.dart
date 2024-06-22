
import 'package:flutter/material.dart';



import '../LoSi/UserModel.dart';
import '../LoSi/login.dart';
import '../LoSi/page.dart';
import '../inDrawar/OurServices.dart';
import '../inDrawar/Settings/Mode/Views/SetSetting.dart';
import '../inDrawar/Settings/infoUser/information.dart';
import '../view/splash_view.dart';
import 'pick_image.dart';

class MyDrawerScreen extends StatelessWidget {
  final UserModel userModel;
  const MyDrawerScreen({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black26,
                // image: DecorationImage(
                //     image: AssetImage(
                //       "assets/abstract-background-brown-smoke-texture-cinematic-design.jpg",
                //     ),
                //     fit: BoxFit.fill,
                //     )
            ),

            accountName: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'Hello ${userModel.userName}👋',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            accountEmail: Text('${userModel.email}'),
            currentAccountPicture: PickImage(),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=> UserProfilePage(email: userModel.email)));
    },
            title: Text('Information'),
            leading: ImageIcon(
              AssetImage("assets/id-card.png"),
            ),
          ),

          ListTile(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder:(context)=> SetSetting()));
            },
            title: Text('APP Settings'),
            leading: ImageIcon(
              AssetImage("assets/maintenance.png"),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 0.2,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),

          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> FireHousePage()));


            },
            title: Text('Our Services'),
            leading: ImageIcon(
              AssetImage("assets/customer-service2.png"),
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=> SplashView()));

            },
            title: Text('Contact us'),
            leading: ImageIcon(
              AssetImage("assets/contact.png"),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 0.2,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),

          // ListTile(
          //   title: Text('About us'),
          //   leading: ImageIcon(AssetImage("assets/information.png"),),
          // ),
          // ListTile(
          //   title: Text('Feedback'),
          //   leading: ImageIcon(AssetImage("assets/review.png"),),
          // ),
          //
          // ListTile(
          //   onTap: (){},
          //   title: Text('FAQs'),
          //   leading: ImageIcon(
          //     AssetImage("assets/faq.png"),
          //   ),
          // ),
          ListTile(
            onTap: (){},
            title: Text('Share',style: TextStyle(color: Colors.grey)),
            leading: ImageIcon(
              AssetImage("assets/share.png"),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
              );
            },
            title: Text('Sign Out'),
            leading: ImageIcon(
              color: Colors.red,
              AssetImage("assets/logout (3).png"),
            ),
          )

        ],
      ),
    );
  }
}
