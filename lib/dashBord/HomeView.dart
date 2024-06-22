import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Drawer/MyDrawerScreen.dart';
import '../LoSi/UserModel.dart';
import '../WPage/Warning.dart';
import 'CustomArcPainter.dart';
import 'SegmentButton.dart';
import 'SubScriptionHomeRow.dart';
import 'bill_view.dart';

@pragma('vm:entry-point')

class HomeView extends StatefulWidget {
  final UserModel userModel;

  const HomeView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('esp');
  dynamic snapshotValue;
  bool isSubscription = true;
  bool isConnected = true;
  bool isWarningDisplayed = false;
  dynamic gasSensorValue;
  dynamic flameSensorValue;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  List subArr = [
    {"name": "Depends on the gas used", "price": "Natural Gas"},
    {"name": "Warning Status Value", "price": "Greater than 1000"},
  ];

  List bilArr = [
    {"name": "Normal Status Value", "price": "Greater than 3500"},
    {"name": "Warning Status Value", "price": "Less than 3500"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _listenForChanges();
    _initializeNotifications();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if ((gasSensorValue is int && gasSensorValue > 1000 && !isWarningDisplayed)||( flameSensorValue is int && flameSensorValue < 3500 && !isWarningDisplayed)) {
        setState(() {
          isWarningDisplayed = true;
        });
        _navigateToWarningPage();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if ((gasSensorValue is int && gasSensorValue > 1000 && !isWarningDisplayed)||( flameSensorValue is int && flameSensorValue < 3500 && !isWarningDisplayed)) {
        setState(() {
          isWarningDisplayed = true;
        });
        _navigateToWarningPage();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer when disposing
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkForWarning(); // Check for warning when the app resumes
    }
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      1,
      'Warning!',
      'Gas sensor value is greater than 1000! or Flame Sensor value is less than 3500! ',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void _listenForChanges() {
    databaseRef.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      setState(() {
        snapshotValue = snapshot.value;
        isConnected = true; // Update connection status
        _updateSensorValues();
      });
      _checkForWarning(); // Check if warning needs to be displayed
    }, onError: (error) async {
      print("Failed to fetch data: $error");
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        _handleConnectionLoss();
      }
    });
  }

  void _updateSensorValues() {
    if (snapshotValue != null && snapshotValue is Map) {
      gasSensorValue = snapshotValue.values.last;
    }
  }

  void _checkForWarning() {
    dynamic flameSensorValue;

    if (snapshotValue != null && snapshotValue is Map) {
      gasSensorValue = snapshotValue.values.last;
      flameSensorValue = snapshotValue.values.first;

      if (gasSensorValue is int && gasSensorValue > 1000 && !isWarningDisplayed) {
        setState(() {
          isWarningDisplayed = true;
        });
        _showNotification(); // Show notification
        _navigateToWarningPage();
      }
      if (flameSensorValue is int && flameSensorValue < 3500 && !isWarningDisplayed) {
        setState(() {
          isWarningDisplayed = true;
        });
        _showNotification();
        _navigateToWarningPage();
      }
    }
  }

  void _handleConnectionLoss() {
    setState(() {
      isConnected = false; // Update connection status
    });
    if (!isWarningDisplayed) {
      setState(() {
        isWarningDisplayed = true;
      });
      _navigateToWarningPage();
    }
  }

  void _navigateToWarningPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.isCurrent == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Warning(userModel: widget.userModel,)),
        ).then((_) {
          // Reset warning display flag when the warning page is popped
          setState(() {
            isWarningDisplayed = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    dynamic flameSensorValue;

    if (snapshotValue != null && snapshotValue is Map) {
      gasSensorValue = snapshotValue.values.last;
      flameSensorValue = snapshotValue.values.first;
    }

    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawerScreen(userModel: widget.userModel),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: media.width * 1.1,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: media.width * 0.05),
                        width: media.width * 0.72,
                        height: media.width * 0.72,
                        child: CustomPaint(
                          painter: CustomArcPainter(
                            end: gasSensorValue?.toDouble() ?? 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Spacer(),
                            IconButton(
                              onPressed: () {

                                if(flameSensorValue<=3500){
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(

                                      title: Text("Flame Sensor"),
                                      content: Text('Flame Sensor Value: $flameSensorValue     There is a fire', style: TextStyle(fontSize: 15,color: Colors.red,fontWeight: FontWeight.bold)),
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
                                }else{
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(

                                      title: Text("Flame Sensor"),
                                      content: Text('Flame Sensor Value: $flameSensorValue    There is no fire ', style: TextStyle(fontSize: 15)),
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

                              },
                              icon: Image.asset(
                                "assets/information.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      SizedBox(
                        height: media.width * 0.25,
                      ),
                      Text(
                        "${gasSensorValue ?? 'Loading'}",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.055,
                      ),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Gas Sensor Value",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentButton(
                      title: "Gas Sensor Range",
                      isActive: isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SegmentButton(
                      title: "Flame Sensor Range",
                      isActive: !isSubscription,
                      onPressed: () {
                        setState(() {
                          isSubscription = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (isSubscription)
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subArr.length,
                itemBuilder: (context, index) {
                  var sObj = subArr[index];

                  return SubScriptionHomeRow(
                    sObj: sObj,
                    onPressed: () {},
                  );
                },
              ),
            if (!isSubscription)
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bilArr.length,
                itemBuilder: (context, index) {
                  var sObj = bilArr[index];

                  return UpcomingBillRow(
                    sObj: sObj,
                    onPressed: () {},
                  );
                },
              ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
    );
  }
}
