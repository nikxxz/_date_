import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:waga/ui/pages/Registration/gender.dart';

class NameReg extends StatefulWidget {
  @override
  _NameRegState createState() => _NameRegState();
}

class _NameRegState extends State<NameReg> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String username = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1, vertical: size.height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "your display name.",
                style: TextStyle(
                  fontSize: size.width * 0.15,
                  color: Colors.red[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: Colors.black),
                onChanged: (val) {
                  setState(() => username = val.trim());
                },
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field cannot be left blank';
                  } else if (value.length < 3) {
                    return 'Display name should be minimum 3 characters long';
                  } else if (value.length > 15) {
                    return 'Display name should be maximum 15 characters long';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                    labelText: 'Display Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              Container(
                padding: EdgeInsets.all(size.height * 0.02),
                height: size.height * 0.1,
                width: size.width * 0.35,
                child: Material(
                  color: Colors.transparent,
                  child: BouncingWidget(
                    duration: Duration(milliseconds: 150),
                    scaleFactor: 3.0,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                            context,
                            SwipeablePageRoute(
                              builder: (context) => GenderReg(
                                _nameController.text.trim(),
                              ),
                            ));
                      }
                    },
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.red[400],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
