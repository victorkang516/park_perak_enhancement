import 'package:flutter/material.dart';
import 'package:park_perak_enhancement/components/pay_for_parking/vehicle_card.dart';
import 'package:park_perak_enhancement/constants.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  final List<String> vehicleItems = [
    'PPP1913',
    'AFK6039',
    'PPP1913',
  ];

  void addItem(String plateNo) {
    setState(() {
      vehicleItems.add(plateNo);
    });
  }

  void removeItem(String plateNo) {
    setState(() {
      vehicleItems.remove(plateNo);
    });
  }

  void openAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new vehicle'),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: 'Plate number'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                addItem(_textEditingController.text);
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('ADD'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Color.fromRGBO(0, 0, 0, 0.5)),
        title: const Text('Choose Vehicle'),
        titleTextStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAlertDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                height: 50,
                child: const Text('Select a vehicle or Add a new vehicle')),
            Container(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              height: height - 200,
              child: ListView.builder(
                itemCount: vehicleItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return VehicleCard(
                    plateNo: vehicleItems[index], removeItem: removeItem,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
