import 'package:bouncing_widget/bouncing_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import 'bodyType.dart';

class OccReg extends StatefulWidget {
  @override
  _OccRegState createState() => _OccRegState();
}

class _OccRegState extends State<OccReg> {
  int _index;
  String occupation;
  User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    occupation = '';
    _index = 0;
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
                    child: Text('OCCUPATION',
                        style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFF54486E),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 500,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 1;
                              occupation = "Student";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 1
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Student',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 2;
                              occupation = "Sales / Marketing";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 2
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Sales / Marketing',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 3;
                              occupation = "Administration";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 3
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Administration',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 4;
                              occupation = "Executive / Management";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 4
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Executive / Management',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 5;
                              occupation = "Architecture / Design";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 5
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Architecture / Design',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 6;
                              occupation = "Technology / Science / Engineering";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 6
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Technology / Science / Engineering',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 7;
                              occupation = "Labor / Construction";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 7
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Labor / Construction',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 8;
                              occupation = "Art / Music / Writing";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 8
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Art / Music / Writing',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 9;
                              occupation = "Entertainment / Media";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 9
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Entertainment / Media',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 10;
                              occupation = "Banking / Finance / Accounting";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 10
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Banking / Finance / Accounting',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 11;
                              occupation =
                                  "Non Profit Organization / Philanthropy";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 11
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Non Profit Organization / Philanthropy',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 12;
                              occupation = "Education";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 12
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Education',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 13;
                              occupation = "Hospitality";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 13
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Hospitality',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 14;
                              occupation = "Medical / Dental / Health";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 14
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Medical / Dental / Health',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 15;
                              occupation = "Military";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 15
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Military',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 16;
                              occupation = "Politics / Government";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 16
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Politics / Government',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 17;
                              occupation = "Travel / Transportation";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 17
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Travel / Transportation',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 18;
                              occupation = "Legal";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 18
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Legal',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 19;
                              occupation = "Retail";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 19
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Retail',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 20;
                              occupation = "Self Employed / Entrepreneur";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 20
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Self Employed / Entrepreneur',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 21;
                              occupation = "Retired";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 21
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Retired',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _index = 22;
                              occupation = "Other";
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            width: 500,
                            decoration: BoxDecoration(
                              color: _index == 22
                                  ? Color(0xFF6B8E4E).withOpacity(0.75)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Other',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 45),
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
                          // await FirestoreDatabase(userID: user.uid)
                          //     .updateUser('occupation', occupation);
                          Navigator.of(context).push(SwipeablePageRoute(
                              builder: (context) => BodyType()));
                        },
                        child: Row(
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.75),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              FlutterIcons.md_arrow_round_forward_ion,
                              color: Color(0xFF6B8E4E),
                            )
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
