import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waga/Payments.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class UserProfile extends StatefulWidget {
  final userId;

  const UserProfile({@required this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String profileImageURL;
  String name;
  String sex;
  String age;
  String interestedIn;
  Timestamp dob;
  int totalAmount = 1;
  Razorpay _razorpay;
  DateTime expiry = DateTime.now().subtract(Duration(days: 1));
  GeoPoint location;
  String city;
  String city1;
  List<Placemark> place = [];
  Placemark placemark;

  @override
  void initState() {
    super.initState();
    profileImageURL = '';
    name = '';
    sex = '';
    interestedIn = '';
    city = '';
    city1 = '';
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String name) async {
    String username = '';
    var options = {
      'key': 'rzp_test_wlttW6y3ig7DQH',
      'amount': totalAmount * 100,
      'name': 'Matchmaker',
      'description': 'Test Payment',
      'prefill': {'contact': username, 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    SnackBar(content: Text('Succesful ' + response.paymentId));
    Payments(userId: widget.userId)
        .updatePaymentInfo(DateTime.now().add(Duration(days: 1)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    SnackBar(
        content: Text(
            'ERROR ! ' + response.code.toString() + " - " + response.message));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SnackBar(content: Text('External Wallet ' + response.walletName));
  }

  void _getPlace(latitude, longitude) async {
    List<Placemark> placem =
        await placemarkFromCoordinates(latitude, longitude);

    Placemark placemark = placem[0];
    String name = placemark.name;
    String subLocality = placemark.subLocality;
    String locality = placemark.locality;
    String administrativeArea = placemark.administrativeArea;
    String postalCode = placemark.postalCode;
    String country = placemark.country;
    String address =
        "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
    setState(() {
      city = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          profileImageURL = documentSnapshot['photoUrl'];
          name = documentSnapshot['name'];
          sex = documentSnapshot['gender'];
          interestedIn = documentSnapshot['interestedIn'];
          dob = documentSnapshot['age'];
          location = documentSnapshot['location'];
        });
      } else {
        print('Document does not exist on the database');
      }
    });

    setState(() {
      age = (DateTime.now().year - dob.toDate().year).toString();
    });

    _getPlace(location.latitude, location.longitude);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.35,
                width: size.width,
                child: Image.network(
                  profileImageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.025,
                    horizontal: size.width * 0.05),
                height: size.height * 0.59,
                width: size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      name,
                      style: GoogleFonts.aBeeZee(
                          fontSize: size.width * 0.1,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      sex + ', ' + age,
                      style: GoogleFonts.aBeeZee(fontSize: size.width * 0.05),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      city,
                      style: GoogleFonts.aBeeZee(fontSize: size.width * 0.05),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
