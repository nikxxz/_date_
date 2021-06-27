import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:_date_/ui/pages/likesYou.dart';
import 'package:_date_/ui/pages/matches.dart';
import 'package:_date_/ui/pages/messages.dart';
import 'package:_date_/ui/pages/search.dart';
import 'package:_date_/ui/pages/userProfile.dart';

class Tabs extends StatefulWidget {
  final userId;

  const Tabs({@required this.userId});

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  PageController _pageController;
  int pageChanged;
  int currentIndex;
  String profileImageURL;
  String title;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
    pageChanged = 0;
    currentIndex = 2;
    profileImageURL = '';
    title = ' Find Match';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _titleChange(index) {
      if (currentIndex == 0) {
        setState(() {
          title = ' Likes You';
        });
      } else if (currentIndex == 1) {
        setState(() {
          title = ' Matched ';
        });
      } else if (currentIndex == 2) {
        setState(() {
          title = ' Find Match';
        });
      } else if (currentIndex == 3) {
        setState(() {
          title = ' Chat';
        });
      }
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          profileImageURL = documentSnapshot['photoUrl'];
        });
      } else {
        print('Document does not exist on the database');
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          title,
          style: GoogleFonts.dawningOfANewDay(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Container(
            width: 58,
            padding: EdgeInsets.only(right: 10, top: 10),
            child: BouncingWidget(
              duration: Duration(milliseconds: 150),
              scaleFactor: 3.0,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserProfile(userId: widget.userId)));
              },
              child: Hero(
                tag: 'userImage',
                child: CircleAvatar(
                  backgroundImage: profileImageURL != ''
                      ? NetworkImage(
                          profileImageURL,
                        )
                      : Image.asset('assets/profilephoto.png'),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red[400],
        unselectedItemColor: Colors.black87,
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          _pageController.animateToPage(
            value,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon:
                Icon(FlutterIcons.like2_ant, size: currentIndex == 0 ? 45 : 20),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FlutterIcons.heart_evi,
              size: currentIndex == 1 ? 45 : 20,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon:
                Icon(EvaIcons.peopleOutline, size: currentIndex == 2 ? 45 : 20),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FlutterIcons.message_circle_fea,
                size: currentIndex == 3 ? 45 : 20),
            label: "",
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
            _titleChange(currentIndex);
          });
        },
        children: [
          Container(
            child: LikesYou(
              userId: widget.userId,
            ),
          ),
          Container(
            child: Matches(
              userId: widget.userId,
            ),
          ),
          Container(
            child: Search(
              userId: widget.userId,
            ),
          ),
          Container(
            child: Messages(
              userId: widget.userId,
            ),
          ),
        ],
      ),
    );
  }
}
