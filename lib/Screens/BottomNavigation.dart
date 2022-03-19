import 'package:flutter/material.dart';
import 'Home.dart';
import 'Products.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Home(),
    Products(),
    Attendance(),
    Earnings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              primaryColor: Color(0xff707070),
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.yellow))),

          child: Container(
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: -3, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: new BottomNavigationBar(
                selectedItemColor: Color(0xff707070),
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                items: [
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home_filled),
                    label: "Home",
                  ),
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.plagiarism_outlined),
                    label: "Products",
                    activeIcon: new Icon(Icons.plagiarism),
                  ),
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.insert_chart_outlined_rounded),
                    label: "Attendance",
                    activeIcon: new Icon(Icons.insert_chart_rounded),
                  ),
                  new BottomNavigationBarItem(
                    icon: new Icon(Icons.settings_outlined),
                    label: "Earnings",
                    activeIcon: new Icon(Icons.settings),
                  ),
                ],
                onTap: (value) => _onItemTapped(value),
              ),
            ),
          ),
        ),

        body: _pages.elementAt(_selectedIndex)
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class Earnings extends StatefulWidget {
  const Earnings({Key key}) : super(key: key);

  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F8FB),
      appBar: AppBar(
        title: Text("Earnings"),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 13, 5, 13),
          child: Container(
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 15,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),);
  }
}

class Attendance extends StatefulWidget {
  const Attendance({Key key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F8FB),
      appBar: AppBar(
        title: Text("Attendance Report"),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 13, 5, 13),
          child: Container(
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 15,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),);
  }
}

