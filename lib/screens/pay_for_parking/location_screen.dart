import 'package:flutter/material.dart';
import 'package:park_perak_enhancement/constants.dart';
import 'package:park_perak_enhancement/components/pay_for_parking/pbt_card.dart';

import '../../class/pbt.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final List<PBT> pbtItems = [
    const PBT(pbtName: 'IPOH', pbtLogoPath: 'assets/daerah_ipoh_logo.png'),
    const PBT(pbtName: 'BATU GAJAH', pbtLogoPath: 'assets/daerah_batugajah_logo.png'),
    const PBT(pbtName: 'GERIK', pbtLogoPath: 'assets/daerah_gerik_logo.png'),
    const PBT(pbtName: 'KAMPAR', pbtLogoPath: 'assets/daerah_kampar_logo.png'),
    const PBT(pbtName: 'KERIAN', pbtLogoPath: 'assets/daerah_kerian_logo.png'),
    const PBT(pbtName: 'KUALA KANGSAR', pbtLogoPath: 'assets/daerah_kuala-kangsar_logo.png'),
    const PBT(pbtName: 'LENGGONG', pbtLogoPath: 'assets/daerah_lenggong_logo.jpeg'),
    const PBT(pbtName: 'MANJUNG', pbtLogoPath: 'assets/daerah_manjung_logo.png'),
    const PBT(pbtName: 'PENGKALAN HULU', pbtLogoPath: 'assets/daerah_pengkalanhulu_logo.png'),
    const PBT(pbtName: 'PERAK TENGAH', pbtLogoPath: 'assets/daerah_peraktengah_logo.png'),
    const PBT(pbtName: 'SELAMA', pbtLogoPath: 'assets/daerah_selama_logo.png'),
    const PBT(pbtName: 'TAIPING', pbtLogoPath: 'assets/daerah_taiping_logo.png'),
    const PBT(pbtName: 'TANJUNG MALIM', pbtLogoPath: 'assets/daerah_tanjungmalim_logo.png'),
    const PBT(pbtName: 'TAPAH', pbtLogoPath: 'assets/daerah_tapah_logo.png'),
    const PBT(pbtName: 'TELUK INTAN', pbtLogoPath: 'assets/daerah_telukintan_logo.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          iconTheme: const IconThemeData(color: Color.fromRGBO(0, 0, 0, 0.5)),
          title: const Text('Choose Location'),
          titleTextStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        body: GridView.builder(
          itemCount: pbtItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return PBTCard(
              pbtLogoPath: pbtItems[index].pbtLogoPath,
              pbtName: pbtItems[index].pbtName,
            );
          },
        ));
  }
}
