import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:rflutter_alert/rflutter_alert.dart';


import 'Messages.dart';
import '../Drawer/MyDrawerScreen.dart';

import '../WPage/Warning.dart';



class Messages extends StatefulWidget {
  const Messages({ Key? key }) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}
  String?title ="";
  String?body ="";


  
class _MessagesState extends State<Messages> {


  Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message)async
  {

    if(kDebugMode){
      print(message.messageId);
    }
  }


  void requestPermission()async{
    FirebaseMessaging messaging=FirebaseMessaging.instance;
    NotificationSettings settings=await messaging.requestPermission(

      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if(settings.authorizationStatus==AuthorizationStatus.authorized)
    {
      print("User granted permission");

    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      title=message.notification?.title;
      body=message.notification?.body;
      print('Title :${message.notification?.title}| Body :${message.notification?.body}');

   //    Alert(
   //      context: context,
   //      type: AlertType.warning,
   //      title: title,
   //      desc: body,
   //
   //      buttons: [
   //        DialogButton(
   //          child: Text(
   //            "OK",
   //            style: TextStyle(color: Colors.white, fontSize: 20),
   //          ),
   //          onPressed: () => Navigator.pop(context),
   //          width: 120,
   //        )
   //      ],
   //    ).show();




    });
  }
  void initState(){
    super.initState();

    requestPermission();


  }
  ///////////////////////////////////////////////////




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawerScreen(),
      // bottomNavigationBar: NavBar(),
      //backgroundColor: Colors.grey.shade400,
      appBar: AppBar(

        backgroundColor: Colors.grey.shade400,
        title: Text("Messages"),
        toolbarHeight: 100.0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )

        ),


      ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
             // alignment: Alignment.centerLeft,

              height: 70,
              
              decoration:BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10)
              ),
              child:  Stack(

                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                      mainAxisAlignment:MainAxisAlignment.center ,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(body.toString(),style: TextStyle(fontWeight: FontWeight.w300),),

                        ],

                      ),
                    ),
                  ),

                ],
              ),


            ),


                      ]
        ),



    );
  }
}
