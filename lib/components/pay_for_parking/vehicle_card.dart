import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  final String plateNo;
  final Function(String) removeItem;

  const VehicleCard({Key? key, required this.plateNo, required this.removeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context, plateNo);
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plateNo),
                TextButton(onPressed: () {
                  removeItem(plateNo);
                }, child: const Text('X')),
              ],
            ),
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
