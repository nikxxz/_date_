
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgeReg extends StatefulWidget {
  final String name;
  final String gender;

  const AgeReg(this.name, this.gender);

  @override
  _AgeRegState createState() => _AgeRegState();
}

class _AgeRegState extends State<AgeReg> {
  DateTime dateTime;
  int age = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.075),
                  Text(
                    'your\n age.' + '\n',
                    style: TextStyle(
                        fontSize: size.width * 0.12,
                        color: Colors.red[400],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1),
                  ),
                  Text(
                    age == -1 ? '' : age.toString(),
                    style: TextStyle(
                        fontSize: size.width * 0.1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\n\n\nWe won't show your exact date of birth.\n",
                    style: TextStyle(fontSize: size.width * 0.035),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.75,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() => dateTime = newDate);
                        calculateAge();
                      },
                      minimumYear: 1947,
                      maximumYear: DateTime.now().year,
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Container(
                    child: Material(
                      child: BouncingWidget(
                        duration: Duration(milliseconds: 150),
                        scaleFactor: 3.0,
                        onPressed: () async {
                          Navigator.of(context).push(SwipeablePageRoute(
                              builder: (context) => PrefReg(
                                  widget.name, widget.gender, dateTime)));
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateAge() {
    int ageMonth = 0, ageDay = 0, ageYear = 0;

    int year = int.parse(dateTime.year.toString());
    int month = int.parse(dateTime.month.toString());
    int day = int.parse(dateTime.day.toString());

    int currentYear = int.parse(DateTime.now().year.toString());
    int currentMonth = int.parse(DateTime.now().month.toString());
    int currentDay = int.parse(DateTime.now().day.toString());

    ageYear = currentYear - year;

    if (ageYear <= 0) {
    } else {
      if (currentMonth > month) {
        ageMonth = 1;
        ageDay = 0;
      } else if (currentMonth < month) {
        ageMonth = 0;
        ageDay = 0;
      } else if (currentMonth == month) {
        if (currentDay <= day) {
          ageDay = 1;
          ageMonth = 0;
        } else {
          ageDay = 0;
        }
      }
    }

    setState(() => age = ageYear + ageMonth + ageDay);
  }
}
