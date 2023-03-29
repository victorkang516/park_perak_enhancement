import 'package:flutter/material.dart';

import '../../class/pbt.dart';

class PBTCard extends StatelessWidget {
  final String pbtName;
  final String pbtLogoPath;

  const PBTCard({Key? key, required this.pbtName, required this.pbtLogoPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context, PBT(pbtName: pbtName, pbtLogoPath: pbtLogoPath));
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image(
              image: AssetImage(pbtLogoPath),
              height: 100,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text('MAJLIS BANDARAYA', style: TextStyle(fontSize: 10),),
            Text(pbtName, style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}