import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'age.dart';

class GenderReg extends StatefulWidget {
  final String name;

  const GenderReg(this.name);

  @override
  _PrefRegState createState() => _PrefRegState();
}

class _PrefRegState extends State<GenderReg> {
  String gender = '';
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Column(
            children: [
              Text(
                "\nyour gender.\n",
                style: TextStyle(
                  fontSize: size.width * 0.15,
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 1;
                            gender = 'Male';
                          });
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      _index == 1 ? Colors.red : Colors.black38,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: _index == 1
                                  ? Colors.red[400].withOpacity(0.3)
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Icon(FontAwesomeIcons.mars),
                              ),
                              SizedBox(width: 50.0),
                              Center(
                                child: Text(
                                  'Male',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 2;
                            gender = 'Female';
                          });
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      _index == 2 ? Colors.red : Colors.black38,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: _index == 2
                                  ? Colors.red[400].withOpacity(0.3)
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Icon(FontAwesomeIcons.venus),
                              ),
                              SizedBox(width: 50.0),
                              Center(
                                child: Text(
                                  'Female',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 3;
                            gender = 'Other';
                          });
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      _index == 3 ? Colors.red : Colors.black38,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: _index == 3
                                  ? Colors.red[400].withOpacity(0.3)
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Icon(FontAwesomeIcons.transgenderAlt),
                              ),
                              SizedBox(width: 50.0),
                              Center(
                                child: Text(
                                  'Other',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.065),
                      Container(
                        child: Material(
                          color: Colors.white,
                          child: BouncingWidget(
                            duration: Duration(milliseconds: 150),
                            scaleFactor: 4.0,
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  SwipeablePageRoute(
                                    builder: (context) =>
                                        AgeReg(widget.name, gender),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.07),
                                ),
                                SizedBox(
                                  width: size.width * 0.025,
                                ),
                                Icon(FlutterIcons.md_arrow_round_forward_ion)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
