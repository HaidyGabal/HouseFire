import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'Control_Mess_Listview/ListView_Mess.dart';
import 'From_Firebase/realTime.dart';

import 'LoSi/login.dart';
import 'LoSi/page.dart';
import 'From_Firebase/Messages.dart';

import 'Drawer/MyDrawerScreen.dart';
import 'MyHomePage.dart';
import 'NewBills/Display_Bills.dart';
import 'Services/ddservices.dart';
import 'WPage/Warning.dart';
import 'anmdrawar/newDrawar.dart';

import 'dashBord/HomeView.dart';
import 'firebase_options.dart';
import 'inDrawar/Settings/Mode/Provider/provider.dart';
import 'inDrawar/Settings/Mode/Views/SetSetting.dart';
import 'inDrawar/Settings/infoUser/information.dart';
import 'interface/Onboboarding/onboarding_view.dart';
import 'interface/Splash.dart';


@pragma('vm:entry-point')
Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message)async
{
  if(kDebugMode){
    print(message.messageId);
  }
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging messaging =FirebaseMessaging.instance;
  // messaging.subscribeToTopic("Topic");
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message) async {


  if (message.data['type'] == 'warning' && message.data['value'] > 2500) {

    // navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => Warning()));

  }
}


class MyApp extends StatefulWidget {

  // final bool onboarding;
  // const MyApp({super.key, this.onboarding = false});

  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context)=>UiProvider()..init(),
        child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child)
            {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'House Fire',

                themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,

                //Our custom theme applied
                darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,

                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
                  useMaterial3: true,
                ),
                home:Splash(),
              );
            }
        ));

  }
}



