import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:park_perak_enhancement/components/horizontal_divider.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/screens/pay_for_parking/location_screen.dart';
import 'package:park_perak_enhancement/screens/pay_for_parking/vehicle_screen.dart';

class PayForParkingScreen extends StatefulWidget {
  const PayForParkingScreen({Key? key}) : super(key: key);

  @override
  State<PayForParkingScreen> createState() => _PayForParkingScreenState();
}

class _PayForParkingScreenState extends State<PayForParkingScreen> {
  String pbtName = '';
  String pbtLogoPath = '';
  String plateNo = '';

  String myPass = 'Basic';
  List<String> passType = ['Basic', 'Daily', 'Monthly'];

  Duration duration = const Duration(minutes: 30);
  int durationHr = 0;
  int durationMin = 0;

  String amPm = 'AM';

  DateTime endTime = DateTime.now();
  DateTime currentTime = DateTime.now();

  double price = 0.60;
  double amount = 0;

  double accountBalance = 10;

  @override
  void initState() {
    super.initState();
    updateDuration();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
      updateEndTime();
    });
  }

  void updatepbtName(String input){
    setState(() {
      pbtName = input;
    });
  }

  void increaseDuration(){
    if (duration < const Duration(hours: 6, minutes: 30)) {
      duration += const Duration(minutes: 30);
    }
    updateDuration();
  }

  void decreaseDuration(){
    if (duration > const Duration(minutes: 30)) {
      duration -= const Duration(minutes: 30);
    }
    updateDuration();
  }

  void updatePass(String passType){
    setState(() {
      myPass = passType;
    });
  }

  void updateDuration(){
    durationHr = duration.inHours;
    durationMin = duration.inMinutes.remainder(60);
    setState(() {
      duration;
    });
    updateEndTime();
    updateAmount();
  }

  void updateEndTime(){
    endTime = currentTime.add(duration);
    amPm = endTime.hour >= 12 ? 'PM' : 'AM';
    setState(() {
      endTime;
      amPm;
    });
  }

  void updateAmount(){
    setState(() {
      amount = (duration.inMinutes / 60) * price;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Color.fromRGBO(0, 0, 0, 0.5)),
        title: Text('Pay For Parking'),
        titleTextStyle: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Pay'),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.fromLTRB(36, 16, 36, 16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(50),
        child: Container(
          width: width - 100,
          height: height - 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () async {
                    var selectedPBT = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationScreen()));
                    if (selectedPBT != null) {
                      setState(() {
                        pbtName = selectedPBT.pbtName;
                        pbtLogoPath = selectedPBT.pbtLogoPath;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: pbtName.isNotEmpty
                        ? Column(
                            children: [
                              Image(
                                image: AssetImage(pbtLogoPath),
                                height: 100,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Majlis Bandaraya $pbtName'),
                            ],
                          )
                        : Column(
                            children: const [
                              Icon(
                                Icons.add_location_alt,
                                size: 80,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Choose Location'),
                            ],
                          ),
                  )),
              const HorizontalDivider(),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          var selectedPlateNo = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VehicleScreen()));
                          if (selectedPlateNo != null) {
                            setState(() {
                              plateNo = selectedPlateNo;
                            });
                          }
                        },
                        child: plateNo != ''
                            ? Text(plateNo)
                            : const Text('Choose Vehicle')),
                  ),
                ],
              ),
              const HorizontalDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
                  Text('Basic Parking'),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
              const HorizontalDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: decreaseDuration, icon: const Icon(Icons.remove)),
                  Text(durationHr.toString(), style: TextStyle(fontSize: 32),),
                  const Text('HR'),
                  Text(durationMin.toString().padLeft(2, '0'), style: TextStyle(fontSize: 32),),
                  const Text('MIN'),
                  IconButton(onPressed: increaseDuration, icon: const Icon(Icons.add))
                ],
              ),
              const HorizontalDivider(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'End Time',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.5)),
                        ),
                        Row(
                          children: [
                            Text(
                              "${DateFormat('h:mm').format(endTime)}",
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(amPm)
                          ],
                        )
                      ],
                    ),
                    Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.1),
                      height: 50,
                      width: 1,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Amount',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.5)),
                        ),
                        Row(
                          children: [
                            const Text('RM'),
                            Text(
                              amount.toStringAsFixed(2),
                              style: const TextStyle(fontSize: 32),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const HorizontalDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Pay with your Balance', style: TextStyle(color: Colors.grey),),
                  Text('RM${accountBalance.toStringAsFixed(2)}', style: TextStyle(fontSize: 20),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
