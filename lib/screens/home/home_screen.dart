import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:park_perak_enhancement/components/home/active_parking.dart';
import 'package:park_perak_enhancement/components/horizontal_divider.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/screens/pay_for_parking/pay_for_parking_screen.dart';

import '../../class/parking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String emailAddress = 'Email:${FirebaseAuth.instance.currentUser?.email}';

  List<Parking> activeParkingItems = [
    Parking(
        pbtName: 'IPOH',
        plateNo: 'AKN6039',
        duration: 30,
        endTime: DateTime.now().add(Duration(minutes: 30)),
        amount: 0.30)
  ];

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: 'Compound',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Balance',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                      Text(
                        'RM4.60',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Top Up'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: EdgeInsets.fromLTRB(36, 12, 36, 12),
                    ),
                  )
                ],
              ),
            ),
          ),
          activeParkingItems.isNotEmpty
              ? Container(
                  height: size.height * 0.7,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      children: [
                        ActiveParking(),

                      ],
                    ),
                  ),
                )
              : Container(
                  height: size.height * 0.7,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/parking.png'),
                          height: 100,
                        ),
                        Text('No active parking at the moment'),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PayForParkingScreen()),
                            );
                          },
                          child: Text('Pay For Parking Now'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: EdgeInsets.fromLTRB(36, 12, 36, 12),
                          ),
                        )
                      ],
                    ),
                  ),
                )
        ],
      )),
    );
  }
}
