import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_/bloc/matches/matches_bloc.dart';
import 'package:date_/bloc/matches/matches_event.dart';
import 'package:date_/bloc/matches/matches_state.dart';
import 'package:date_/models/user.dart';
import 'package:date_/repositories/matchesRepository.dart';
import 'package:date_/ui/widgets/EmptyMatched.dart';
import 'package:date_/ui/widgets/iconWidget.dart';
import 'package:date_/ui/widgets/matchedTiles.dart';
import 'package:date_/ui/widgets/pageTurn.dart';
import 'package:date_/ui/widgets/profile.dart';
import 'package:date_/ui/widgets/userGender.dart';

import 'detail_page.dart';
import 'messaging.dart';

class LikesYou extends StatefulWidget {
  final String userId;

  const LikesYou({this.userId});

  @override
  _LikesYouState createState() => _LikesYouState();
}

class _LikesYouState extends State<LikesYou> {
  MatchesRepository matchesRepository = MatchesRepository();
  MatchesBloc _matchesBloc;

  User selectedUser;

  User currentUser;

  int difference;

  Timestamp user_age;
  String user_name;
  String user_gender;
  User user1;

  getDifference(GeoPoint userLocation) async {
    Position position = await Geolocator().getCurrentPosition();

    double location = await Geolocator().distanceBetween(userLocation.latitude,
        userLocation.longitude, position.latitude, position.longitude);

    difference = location.toInt();
  }

  @override
  void initState() {
    _matchesBloc = MatchesBloc(matchesRepository: matchesRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<MatchesBloc, MatchesState>(
      bloc: _matchesBloc,
      builder: (BuildContext context, MatchesState state) {
        if (state is LoadingState) {
          _matchesBloc.add(LoadListsEvent(userId: widget.userId));
          return CircularProgressIndicator();
        }
        if (state is LoadUserState) {
          return StreamBuilder<QuerySnapshot>(
            stream: state.selectedList,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.data.docs != null) {
                List user = snapshot.data.docs;
                if (user.length == 0) {
                  return EmptyMatched();
                } else {
                  return Container(
                    height: size.height * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: Swiper(
                        itemCount: user.length,
                        itemWidth: size.width * 0.9,
                        itemHeight: size.height * 0.7,
                        layout: SwiperLayout.STACK,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              selectedUser = await matchesRepository
                                  .getUserDetails(user[index].id);
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) =>
                                      DetailPage(user: selectedUser),
                                ),
                              );
                            },
                            child: Container(
                              child: Center(
                                child: SizedBox(
                                  height: size.width * 0.9,
                                  width: size.height * 0.75,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                    child: Stack(
                                      children: [
                                        Container(
                                          child: Hero(
                                            tag: user[index].id,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                              child: Image.network(
                                                user[index].data()['photoUrl'],
                                                fit: BoxFit.cover,
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    stops: [
                                                      0.1,
                                                      0.3,
                                                      0.7,
                                                      1
                                                    ],
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.15),
                                                      Colors.black
                                                          .withOpacity(0.275),
                                                      Colors.black
                                                          .withOpacity(0.38),
                                                      Colors.black
                                                          .withOpacity(0.5)
                                                    ]),
                                                borderRadius:
                                                    BorderRadius.circular(32))),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 20),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(user[index].data()['name'],
                                                    style: GoogleFonts.sen(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30,
                                                        color: Colors.white,
                                                        letterSpacing: 1.3)),
                                                Row(
                                                  children: <Widget>[
                                                    Text('View profile  ',
                                                        style: GoogleFonts
                                                            .comfortaa(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white)),
                                                    Icon(
                                                      FlutterIcons
                                                          .ios_arrow_forward_ion,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              } else
                return Container();
            },
          );
        }
        return Container();
      },
    );
  }
}
