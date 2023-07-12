import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blood_connect/components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int donationtimes = 0;
  int requesttimes = 0;
  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 45), (timer) {
      setState(() {
        donationtimes < 47 ? donationtimes++ : null;
        requesttimes < 53 ? requesttimes++ : null;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            shadowColor: Colors.red.shade500,
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  SizedBox(
                    height: 300,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                                'assets/images/profile_cover.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          color: Colors.white60,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent, border: Border.all()),
                          child: Image.asset(
                            "assets/images/preson.jpeg",
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(color: Colors.red, thickness: 3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.person_outline),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Name :  Ahmad ahmad',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(color: Colors.red, thickness: 3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.phone_android),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'phone :  +96391000000',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(color: Colors.red, thickness: 3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.list),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Order times :  $requesttimes',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(color: Colors.red, thickness: 3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.handshake),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Donation times :  $donationtimes',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(color: Colors.red, thickness: 3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.perm_identity_sharp),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Identity number :  010101010101',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                 
                ]))),
      ),
    );
  }
}
