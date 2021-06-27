import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waga/bloc/matches/matches_bloc.dart';
import 'package:waga/bloc/matches/matches_event.dart';
import 'package:waga/bloc/matches/matches_state.dart';
import 'package:waga/models/user.dart';
import 'package:waga/repositories/matchesRepository.dart';
import 'package:waga/ui/widgets/EmptyMatched.dart';
import 'package:waga/ui/widgets/iconWidget.dart';
import 'package:waga/ui/widgets/matchedTiles.dart';
import 'package:waga/ui/widgets/pageTurn.dart';
import 'package:waga/ui/widgets/profile.dart';
import 'package:waga/ui/widgets/userGender.dart';

import 'detail_page.dart';
import 'messaging.dart';

class Matches extends StatefulWidget {
  final String userId;

  const Matches({this.userId});

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  MatchesRepository matchesRepository = MatchesRepository();
  MatchesBloc _matchesBloc;

  User selectedUser;

  User currentUser;

  int difference;

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
            stream: state.matchedList,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.data.docs != null) {
                final user = snapshot.data.docs;
                if (user.length == 0) {
                  return EmptyMatched();
                } else {
                  return Container(
                    height: size.height * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Swiper(
                      itemCount: user.length,
                      itemWidth: size.width * 0.8,
                      itemHeight: size.height * 0.6,
                      layout: SwiperLayout.STACK,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        _users(user, index);
                        return InkWell(
                          onTap: () {
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
                                      borderRadius: BorderRadius.circular(32)),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: Hero(
                                          tag: user[index]['photoUrl'],
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            child: Image.network(
                                              user[index]['photoUrl'],
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(user[index]['name'],
                                                  style: GoogleFonts.sen(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30,
                                                      color: Colors.white,
                                                      letterSpacing: 1.3)),
                                              Row(
                                                children: <Widget>[
                                                  Text('View profile  ',
                                                      style:
                                                          GoogleFonts.comfortaa(
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
                  );
                }
              } else {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        }
        return Container();
      },
    );
  }

  _users(user, index) async {
    selectedUser = await matchesRepository.getUserDetails(user[index].id);
    currentUser = await matchesRepository.getUserDetails(widget.userId);
    await getDifference(selectedUser.location);
  }
}
