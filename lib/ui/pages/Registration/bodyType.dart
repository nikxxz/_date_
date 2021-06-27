import 'package:bouncing_widget/bouncing_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../home.dart';


class BodyType extends StatefulWidget {
  @override
  _BodyTypeState createState() => _BodyTypeState();
}

class _BodyTypeState extends State<BodyType> {
  int _index;
  String bodyType;
  User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _index = 0;
    bodyType = '';
  }

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
                    padding: EdgeInsets.only(top: 75),
                    child: Text('BODY TYPE',
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                height: 500,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 1;
                          bodyType = "Slim";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 1
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Slim',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 2;
                          bodyType = "Average";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 2
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Average',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 3;
                          bodyType = "Atheletic";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 3
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Atheletic',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 4;
                          bodyType = "Muscular";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 4
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Muscular',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 5;
                          bodyType = "A few extra pounds";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 5
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'A few extra pounds',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 6;
                          bodyType = "Stocky";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 6
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Stocky',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 7;
                          bodyType = "Big-boned";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 7
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Big-boned',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 8;
                          bodyType = "Supersized";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 8
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Supersized',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 9;
                          bodyType = "Other";
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        width: 500,
                        decoration: BoxDecoration(
                          color: _index == 9
                              ? Color(0xFF6B8E4E).withOpacity(0.75)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Other',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
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
                        onPressed: () async{
                          // await FirestoreDatabase(userID: user.uid)
                          //     .updateUser('body_type', bodyType);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Home()));
                        },
                        child: Row(
                          children: [
                            Text(
                              "FINISH",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(FlutterIcons.md_arrow_round_forward_ion)
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
