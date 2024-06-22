import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../Control_Mess_Listview/ListView_Mess.dart';
import '../LoSi/UserModel.dart';
import '../Services/ddservices.dart';

@pragma('vm:entry-point')
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  //
  // if (message.data['type'] == 'warning' && message.data['value'] > 2000) {
  //
  //   navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => Warning()));
  //
  // }
}


class Warning extends StatefulWidget {

  final UserModel userModel;

  const Warning({Key? key, required this.userModel}) : super(key: key);
  @override
  _WarningState createState() => _WarningState();
}

class _WarningState extends State<Warning> with WidgetsBindingObserver {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    playAudio();
  }

  Future<void> playAudio() async {
    try {
      final path = AssetSource("digital-alarm-clock-151920.mp3");
      await audioPlayer.play(path);
    } catch (e) {
      // Handle audio play error
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/detailed-structure-marble-natural-pattern-background-design.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "House🔥Fire",
                style: Theme.of(context).textTheme.headline1,
              ),
              const RippleAnimation(
                color: Colors.deepOrange,
                delay: Duration(milliseconds: 300),
                repeat: true,
                minRadius: 75,
                ripplesCount: 6,
                duration: Duration(milliseconds: 6 * 300),
                child: Text("🔔", style: TextStyle(fontSize: 80)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Stop",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 150.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DDServices(accessToken:widget.userModel)));
                      },
                      child: Text(
                        "Services",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}