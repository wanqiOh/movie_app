import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:movieapp/FadeAnimation.dart';

//GoogleSignIn _googleSignIn = GoogleSignIn(
//  scopes: <String>[
//    'email',
//    'https://www.googleapis.com/auth/contacts.readonly',
//  ],
//);

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';
//  GoogleSignInAccount _currentUser;
//  String _contactText;

  Future<Null> _loginWithFB() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
          Navigator.of(context).pushNamed('/HomePage');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

//  Future<void> _handleGetContact() async {
//    setState(() {
//      _contactText = "Loading contact info...";
//    });
//    final http.Response response = await http.get(
//      'https://people.googleapis.com/v1/people/me/connections'
//          '?requestMask.includeField=person.names',
//      headers: await _currentUser.authHeaders,
//    );
//    if (response.statusCode != 200) {
//      setState(() {
//        _contactText = "People API gave a ${response.statusCode} "
//            "response. Check logs for details.";
//      });
//      print('People API ${response.statusCode} response: ${response.body}');
//      return;
//    }
//    final Map<String, dynamic> data = json.decode(response.body);
//    final String namedContact = _pickFirstNamedContact(data);
//    setState(() {
//      if (namedContact != null) {
//        _contactText = "I see you know $namedContact!";
//      } else {
//        _contactText = "No contacts to display.";
//      }
//    });
//  }
//
//  String _pickFirstNamedContact(Map<String, dynamic> data) {
//    final List<dynamic> connections = data['connections'];
//    final Map<String, dynamic> contact = connections?.firstWhere(
//          (dynamic contact) => contact['names'] != null,
//      orElse: () => null,
//    );
//    if (contact != null) {
//      final Map<String, dynamic> name = contact['names'].firstWhere(
//            (dynamic name) => name['displayName'] != null,
//        orElse: () => null,
//      );
//      if (name != null) {
//        return name['displayName'];
//      }
//    }
//    return null;
//  }
//
//  Future<void> _loginWithGoogle() async {
//    try {
//      await _googleSignIn.signIn();
//    } catch (error) {
//      print(error);
//    }
//  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(1.2, Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB( 5, 100, 0, 0),
                      child: Text("L",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 120),
                      child: FlareActor(
                        'assets/playAndpause.flr',
                        animation: 'Full Loop',
                        sizeFromArtboard: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(130, 100, 0, 0),
                      child: Text("GIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
                FadeAnimation(1.5, Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Choose an option to login to an existing account or create a new account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),),
                SizedBox(height: 60,),
                FadeAnimation(1.8, Column(
                    children: <Widget>[
//                      GestureDetector(
//                        onTap:(){
//                            _loginWithGoogle();
//                        },
//                        child: Container(
//                          height: 40.0,
//                          child: Container(
//                            decoration: BoxDecoration(
//                                border: Border.all(
//                                    color: Colors.white,
//                                    style: BorderStyle.solid,
//                                    width: 1.0),
//                                color: Colors.transparent,
//                                borderRadius: BorderRadius.circular(20.0)),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Center(
//                                  child:
//                                  ImageIcon(AssetImage('images/google.png'),color: Colors.white,),
//                                ),
//                                SizedBox(width: 10.0),
//                                Center(
//                                  child: Text('Log in with google',
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.bold,
//                                          fontFamily: 'Montserrat')),
//                                )
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
                      GestureDetector(
                        onTap: (){
                            _loginWithFB();
                        },
                        child: Container(
                          height: 40.0,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.greenAccent,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child:
                                  ImageIcon(AssetImage('images/facebook.png')),
                                ),
                                SizedBox(width: 10.0),
                                Center(
                                  child: Text('Log in with facebook',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat')),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ])),
              ]),
        ));
  }
}