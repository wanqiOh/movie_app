import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/FadeAnimation.dart';
import 'package:movieapp/LoginScreen.dart';
import 'HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
      '/LoginPage': (BuildContext context) => LoginScreen(),
      '/HomePage': (BuildContext context) => HomeScreen(),
    },
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Stack(
          children: <Widget>[
              FlareActor(
                'assets/Background.flr',
                animation: 'Flow',
                sizeFromArtboard: true,
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(1, Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text('M',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 80.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 90),
                      child: FlareActor(
                        'assets/playAndpause.flr',
                        animation: 'Full Loop',
                        sizeFromArtboard: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(160, 100, 0, 0),
                      child: Text('VIE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 90.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,)),
                    ),
                  ],
                )
                ),
                FadeAnimation(1.3,
                    Text(
                      'We promise that you\'ll have the most fuss-free time with this app.',
                      style:
                      TextStyle(
                          color: Colors.white.withOpacity(.7),
                          height: 1.4,
                          fontSize: 20),
                    )),
                SizedBox(height: 90,),
                FadeAnimation(1.7,
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 80.0,
                        width: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green.withOpacity(.4),
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: IconButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed('/LoginPage');
                            },
                            icon: Icon(Icons.forward),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 90,),
              ],
          ),],
        ),
      ),
    );
  }
}