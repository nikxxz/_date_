import 'dart:io';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:im_animations/im_animations.dart';
import 'package:image_picker/image_picker.dart';

import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:date_/repositories/userRepository.dart';
import 'height.dart';

class ProfileImage extends StatefulWidget {
  final String name;
  final String gender;
  final DateTime dateTime;
  final String preference;

  const ProfileImage(this.name, this.gender, this.dateTime, this.preference);

  @override
  _PrefRegState createState() => _PrefRegState();
}

class _PrefRegState extends State<ProfileImage> {
  final UserRepository _userRepository = new UserRepository();
  User user = FirebaseAuth.instance.currentUser;

  int _index = 0;
  File _image;
  GeoPoint location;

  UserRepository get userRepository => _userRepository;

  _getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    location = GeoPoint(position.latitude, position.longitude);
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.07),
              Text(
                "Upload Your Photo",
                style: TextStyle(
                    fontSize: size.width * 0.1, color: Colors.red[400]),
              ),
              Text(
                "\nA great photo of you can catch the eyes of people you're into\n\n",
                style:
                    TextStyle(fontSize: size.width * 0.03, color: Colors.black),
              ),
              SizedBox(height: size.height * 0.025),
              Container(
                height: size.height * 0.25,
                child: ColorSonar(
                  duration: Duration(hours: 0, minutes: 0, seconds: 5),
                  contentAreaRadius: 100.0,
                  waveFall: 15.0,
                  waveMotion: WaveMotion.synced,
                  innerWaveColor: Color(0xFFD9AAC7),
                  middleWaveColor: Color(0xFFD9AAC7).withOpacity(0.65),
                  outerWaveColor: Colors.transparent,
                  child: CircleAvatar(
                    radius: size.height * 0.25,
                    backgroundColor: Colors.white54,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.18),
                            child: Image.file(
                              _image,
                              width: size.height * 0.25,
                              height: size.height * 0.25,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFD9AAC7).withOpacity(0.15),
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.2)),
                            width: size.height * 0.25,
                            height: size.height * 0.25,
                            child: Icon(
                              FlutterIcons.camera_faw,
                              color: Colors.black,
                              size: size.height * 0.075,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.075),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => _index = 1);
                          _imgFromGallery();
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
                                child: Icon(FlutterIcons.photo_faw),
                              ),
                              SizedBox(width: size.width * 0.075),
                              Center(
                                child: Text(
                                  'Choose a Photo',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      GestureDetector(
                        onTap: () {
                          setState(() => _index = 2);
                          _imgFromCamera();
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
                                child: Icon(FlutterIcons.camera_retro_faw),
                              ),
                              SizedBox(width: size.width * 0.07),
                              Center(
                                child: Text(
                                  'Take a picture',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04),
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
                              await userRepository.profileSetup(
                                  _image,
                                  user.uid,
                                  widget.name,
                                  widget.gender,
                                  widget.preference,
                                  widget.dateTime,
                                  location);
                              Navigator.of(context).push(SwipeablePageRoute(
                                  builder: (context) => HeightReg()));
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
                                  width: size.width * 0.025,
                                ),
                                Icon(FlutterIcons.md_arrow_round_forward_ion,
                                    color: Colors.black87)
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

  _imgFromCamera() async {
    final _picker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile image1 = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 70);
    File image = File(image1.path);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final _picker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile image1 = await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 70);
    File image = File(image1.path);

    setState(() {
      _image = image;
    });
  }
}
