import 'package:bouncing_widget/bouncing_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import 'occupation.dart';

class HeightReg extends StatefulWidget {
  @override
  _HeightRegState createState() => _HeightRegState();
}

class _HeightRegState extends State<HeightReg> {
  User user = FirebaseAuth.instance.currentUser;
  int _feetSelector = 0;
  int _inchSelector = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 75, bottom: 25),
                    child: Text('HEIGHT',
                        style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFF6B8E4E),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text(
                'Tell us a lttle more about yourself',
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your',
                    style: TextStyle(color: Colors.black54, fontSize: 24),
                  ),
                  Text(
                    ' Height ',
                    style: TextStyle(color: Color(0xFF6B8E4E), fontSize: 24),
                  ),
                  Text(
                    'is',
                    style: TextStyle(color: Colors.black54, fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text(
                (_feetSelector != 0)
                    ? (_feetSelector.toString() +
                        " Feet " +
                        _inchSelector.toString() +
                        " Inches ")
                    : '',
                style: TextStyle(color: Color(0xFF6B8E4E), fontSize: 32),
              ),
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Feet',
                        style: TextStyle(
                            color: Color(0xFF6B8E4E).withOpacity(0.9),
                            fontSize: 25),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 100,
                        width: 100,
                        child: CupertinoPicker(
                          magnification: 1.25,
                          backgroundColor: Colors.transparent,
                          onSelectedItemChanged: (value) {
                            if (value == 0) {
                              setState(() {
                                _feetSelector = 4;
                                print(_feetSelector);
                              });
                            } else if (value == 1) {
                              setState(() {
                                _feetSelector = 5;
                                print(_feetSelector);
                              });
                            } else if (value == 2) {
                              setState(() {
                                _feetSelector = 6;
                                print(_feetSelector);
                              });
                            } else if (value == 3) {
                              setState(() {
                                _feetSelector = 7;
                                print(_feetSelector);
                              });
                            }
                          },
                          itemExtent: 32.0,
                          children: const [
                            Text('4'),
                            Text('5'),
                            Text('6'),
                            Text('7'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Inches',
                        style: TextStyle(
                            color: Color(0xFF6B8E4E).withOpacity(0.9),
                            fontSize: 25),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 100,
                        width: 100,
                        child: CupertinoPicker(
                          looping: true,
                          magnification: 1.25,
                          backgroundColor: Colors.transparent,
                          onSelectedItemChanged: (value) {
                            setState(() {
                              _inchSelector = value;
                              print(_inchSelector);
                            });
                          },
                          itemExtent: 32.0,
                          children: const [
                            Text('0'),
                            Text('1'),
                            Text('2'),
                            Text('3'),
                            Text('4'),
                            Text('5'),
                            Text('6'),
                            Text('7'),
                            Text('8'),
                            Text('9'),
                            Text('10'),
                            Text('11'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    child: Material(
                      color: Colors.white,
                      shadowColor: Colors.white.withOpacity(0.001),
                      elevation: 15,
                      borderRadius: BorderRadius.circular(40),
                      child: BouncingWidget(
                        duration: Duration(milliseconds: 150),
                        scaleFactor: 4.0,
                        onPressed: () async {
                          if (_feetSelector != 0) {
                            // await FirestoreDatabase(userID: user.uid)
                            //     .updateUser(
                            //         'height_feet', _feetSelector.toString());
                            // await FirestoreDatabase(userID: user.uid)
                            //     .updateUser(
                            //         'height_inch', _inchSelector.toString());
                            Navigator.of(context).push(SwipeablePageRoute(
                                builder: (context) => OccReg()));
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(FlutterIcons.md_arrow_round_forward_ion,
                                color: Color(0xFF6B8E4E).withOpacity(0.8))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
