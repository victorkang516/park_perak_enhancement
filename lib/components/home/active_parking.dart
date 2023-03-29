import 'package:flutter/material.dart';

import '../horizontal_divider.dart';

class ActiveParking extends StatelessWidget {
  const ActiveParking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text('Time Left:'),
                  Row(
                    children: const [
                      Text(
                        '1',
                        style: TextStyle(fontSize: 28),
                      ),
                      Text('HR'),
                      Text(
                        '13',
                        style: TextStyle(fontSize: 28),
                      ),
                      Text('MIN')
                    ],
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text('Extend'))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const HorizontalDivider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                'Basic Parking',
                style: TextStyle(
                    fontSize: 12, color: Colors.grey),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: const [
                    Image(
                      image: AssetImage(
                          'assets/daerah_ipoh_logo.png'),
                      height: 60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Majlis Bandaraya',
                      style: TextStyle(fontSize: 11),
                    ),
                    Text('IPOH')
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text('AKN6039'),
                      const SizedBox(
                        height: 20,
                      ),
                      const HorizontalDivider(),
                      Container(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'End Time',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                        Color.fromRGBO(
                                            0,
                                            0,
                                            0,
                                            0.5)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "7:13",
                                        style: TextStyle(
                                            fontSize: 28),
                                      ),
                                      Text('AM')
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: const Color.fromRGBO(
                                  0, 0, 0, 0.1),
                              height: 50,
                              width: 1,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                        Color.fromRGBO(
                                            0,
                                            0,
                                            0,
                                            0.5)),
                                  ),
                                  Row(
                                    children: [
                                      const Text('RM'),
                                      Text(
                                        '0.30',
                                        style:
                                        const TextStyle(
                                            fontSize:
                                            28),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
