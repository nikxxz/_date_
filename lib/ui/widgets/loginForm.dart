import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waga/bloc/authentication/authentication_bloc.dart';
import 'package:waga/bloc/authentication/authentication_event.dart';
import 'package:waga/bloc/login/login_bloc.dart';
import 'package:waga/bloc/login/login_event.dart';
import 'package:waga/bloc/login/login_state.dart';
import 'package:waga/repositories/userRepository.dart';
import 'package:waga/ui/pages/signUp.dart';

import '../constants.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            // ignore: deprecated_member_use
            ..hideCurrentSnackBar()
            // ignore: deprecated_member_use
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Login Failed"),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }

        if (state.isSubmitting) {
          print("isSubmitting");
          Scaffold.of(context)
            // ignore: deprecated_member_use
            ..hideCurrentSnackBar()
            // ignore: deprecated_member_use
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(" Logging In..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Container(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Center(
                  //   child: Text(
                  //     "login",
                  //     style: TextStyle(
                  //         fontSize: size.width * 0.15,
                  //         color: Colors.red[400],
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 35.0, right: 35.0, top: 35.0, bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email cannot be left blank';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.8))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password cannot be left blank';
                            } else if (value.length < 6) {
                              return 'Password should be atleast 6 Characters';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.6))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                          obscureText: true,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: 'LogInOutBtn',
                          child: Container(
                            padding: EdgeInsets.all(size.height * 0.02),
                            height: size.height * 0.1,
                            child: Material(
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.05),
                              shadowColor: Colors.redAccent,
                              color: Colors.red[400],
                              elevation: 10.0,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    _onFormSubmitted();
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: size.height * 0.02),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.height * 0.027),
                          height: 50.0,
                          child: Material(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.05),
                            color: Colors.transparent,
                            child: GestureDetector(
                              onTap: () async {},
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.05)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: ImageIcon(
                                          AssetImage('assets/google.png')),
                                    ),
                                    SizedBox(width: 15.0),
                                    Center(
                                      child: Text(
                                        'Login With Google',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'New User?',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SignUp(
                                        userRepository: _userRepository,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'switch',
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.04,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
