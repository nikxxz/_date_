import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:_date_/ui/pages/Registration/profileImage.dart';

class PrefReg extends StatefulWidget {
  final String name;
  final String gender;
  final DateTime dateTime;

  const PrefReg(this.name, this.gender, this.dateTime);

  @override
  _PrefRegState createState() => _PrefRegState();
}

class _PrefRegState extends State<PrefReg> {
  String preference = '';
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.035),
              Text(
                "\nyou wish to meet.\n",
                style: TextStyle(
                    fontSize: size.width * 0.15,
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold),
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
                            preference = 'Male';
                          });
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.8,
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
                              SizedBox(width: size.height * 0.035),
                              Center(
                                child: Text(
                                  'Men',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.035),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 2;
                            preference = 'Female';
                          });
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.8,
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
                              SizedBox(width: size.height * 0.035),
                              Center(
                                child: Text(
                                  'Women',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.05),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.035),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = 3;
                            preference = 'all';
                          });
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.8,
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
                                child: Icon(FontAwesomeIcons.peopleArrows),
                              ),
                              SizedBox(width: size.height * 0.035),
                              Center(
                                child: Text(
                                  'Show Me Everyone',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.042),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        child: Material(
                          child: BouncingWidget(
                            duration: Duration(milliseconds: 150),
                            scaleFactor: 3.0,
                            onPressed: () async {
                              Navigator.of(context).push(SwipeablePageRoute(
                                  builder: (context) => ProfileImage(
                                      widget.name,
                                      widget.gender,
                                      widget.dateTime,
                                      preference)));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.07),
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
