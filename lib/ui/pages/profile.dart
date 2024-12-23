
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:_date_/bloc/profile/profile_bloc.dart';
import 'package:_date_/repositories/userRepository.dart';
import 'package:_date_/ui/widgets/profileForm.dart';

import '../constants.dart';

class Profile extends StatelessWidget {
  final _userRepository;
  final userId;

  Profile({@required UserRepository userRepository, String userId})
      : assert(userRepository != null && userId != null),
        _userRepository = userRepository,
        userId = userId;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime;
    File file;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Setup"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(userRepository: _userRepository),
        child: ProfileForm('','',dateTime,'',file),
      ),
    );
  }
}
