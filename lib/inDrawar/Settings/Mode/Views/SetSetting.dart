
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../../AboutUs.dart';
import '../Provider/provider.dart';



class SetSetting extends StatelessWidget {
  const SetSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("App Settings"),
        centerTitle: true,
          automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey,
        )
      ),
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text("Dark theme"),
                trailing: Switch(
                  value: notifier.isDark,
                  onChanged: (value)=>notifier.changeTheme()
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
                  onTap: () {},
                  title: Text('App Version'),
                  trailing: Text(" Last Version",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.green)),
                  leading: const Icon(Icons.security_update_rounded),

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
                onTap: () {},
                title: Text('Privacy Policy',style: TextStyle(color: Colors.grey),),
                leading: const Icon(Icons.privacy_tip_outlined),


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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> AboutUsPage()));

                },
                title: Text('About us'),
                leading: ImageIcon(AssetImage("assets/information.png"),),
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
                onTap: () {},
                title: Text('Feedback',style: TextStyle(color: Colors.grey)),
                leading: ImageIcon(AssetImage("assets/review.png"),),
              ),
            ],
          );
        }
      ),
    );
  }
}
