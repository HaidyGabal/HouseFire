import 'package:flutter/material.dart';

import '../LoSi/UserModel.dart';
import '../NewBills/Display_Bills.dart';
import '../Services/ddservices.dart';
import '../UpdateUser/UpdateUserPage.dart';
import '../dashBord/HomeView.dart';
import '../inDrawar/Settings/Mode/Views/SetSetting.dart';

class NewnavBar extends StatefulWidget {
  final UserModel userModel;

  const NewnavBar({Key? key, required this.userModel}) : super(key: key);

  @override
  _NewnavBarState createState() => _NewnavBarState();
}

class _NewnavBarState extends State<NewnavBar> {
  int currentIndex = 0;
  late List<Widget> _pages;

  bool _isVisible = true; // For showing/hiding the navbar
  bool _isDrawerOpen = false; // Track drawer state

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeView(userModel: widget.userModel),

      DDServices(accessToken: widget.userModel),
      BillsPage(userModel: widget.userModel),
      SetSetting(),
    ];
  }

  void setBottomBarIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _toggleDrawerState(bool isOpen) {
    setState(() {
      _isDrawerOpen = isOpen;
      _isVisible = !isOpen; // Hide navbar when drawer is open
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        IndexedStack(
          index: currentIndex,
          children: _pages,
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: _isVisible ? 0.0 : -70.0,
          left: 0,
          right: 0,
          child: Container(
            width: size.width,
            height: 70, // height nav
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 70),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.5,
                  child: SizedBox(
                    width: size.width,
                    height: 63.0,
                    child: FloatingActionButton(
                      splashColor: Colors.orange.shade100,
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/update-user.png',
                        width: size.width,
                      ),
                      elevation: 0.1,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> UserProfileUpdatePage(email:widget.userModel.email,userName:widget.userModel.userName,)));
                      },
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NewnavBarItem("assets/home.png", "Home", 0, setBottomBarIndex, currentIndex),
                      NewnavBarItem("assets/mail (1).png", "Services", 1, setBottomBarIndex, currentIndex),
                      Container(
                        width: size.width * 0.20,
                      ),
                      NewnavBarItem("assets/invoice.png", "Bills", 2, setBottomBarIndex, currentIndex),
                      NewnavBarItem("assets/maintenance.png", "Settings", 3, setBottomBarIndex, currentIndex),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Pass the toggle callback to MyDrawerScreen
        // MyDrawerScreen(
        //   userModel: widget.userModel,
        //   toggleDrawerState: _toggleDrawerState,
        // ),
      ],
    );
  }
}

class NewnavBarItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final int index;
  final Function(int) onTap;
  final int currentIndex;

  NewnavBarItem(this.iconPath, this.label, this.index, this.onTap, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 9.0),
          child: IconButton(
            icon: Image.asset(
              iconPath,
              width: 35.0,
              height: 30.0,
              color: currentIndex == index ? Colors.orange : Colors.grey.shade400,
            ),
            onPressed: () {
              onTap(index);
            },
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: currentIndex == index ? Colors.orange : Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 25, true); // Change shadow color to red
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
