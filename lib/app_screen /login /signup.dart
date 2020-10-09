import 'package:flutter/material.dart';
import 'package:movie_mock_list/app_screen%20/homePage/homePage.dart';
import 'package:movie_mock_list/utils/Utils.dart';

class SingUp extends StatefulWidget {
  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  var _visibility = true;
  var _rowVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              moveToLastScreen();
            }),
      ),
      body: WillPopScope(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(1.0),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 350,
                ),
                Column(
                  children: [
                    Container(
                      width: 400,
                      height: 35,
                      child: RaisedButton(
                        onPressed: () {
                          moveToHomeScreen();
                        },
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                    image: AssetImage(
                                        'assets/facebook_logo.png'),
                                    height: 20)),
                            Text(
                              "Sign up with Facebook",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 20),
                    Container(
                      width: 400,
                      height: 35,
                      child: RaisedButton(
                        onPressed: () {
                          moveToHomeScreen();
                        },
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                    image: AssetImage('assets/google_logo.png'),
                                    height: 20)),
                            Text(
                              "Sign up with Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.all(5 /**/),
                                child: Container(
                                  height: 1,
                                  width: 50,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        Visibility(
                          visible: _rowVisibility,
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      child: CircleAvatar(
                                        backgroundImage:
                                        AssetImage('assets/apple_logo.png'),
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                      ),
                                      onTap: () {
                                        showAlertDialogBox(context);
                                      },
                                    ),
                                    GestureDetector(
                                      child: CircleAvatar(
                                          backgroundImage:
                                          AssetImage('assets/twitter_logo.png'),
                                          radius: 20),
                                      onTap: () {
                                        showAlertDialogBox(context);
                                      },
                                    ),
                                    GestureDetector(
                                      child: CircleAvatar(
                                          backgroundColor: Colors.yellow,
                                          child: Icon(
                                            Icons.mail,
                                            color: Colors.black,
                                          )),
                                      onTap: () {
                                        showAlertDialogBox(context);
                                      },
                                    )
                                  ]),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _visibility,
                          child: Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: GestureDetector(
                                child: Text(
                                  "SEE MORE OPTIONS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none),
                                ),
                                onTap: () {
                                  setState(() {
                                    _visibility = false;
                                    _rowVisibility = true;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(20 /**/),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: DefaultTextStyle
                                      .of(context)
                                      .style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'By Signing up,you are agree to our',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            decoration: TextDecoration.none)),
                                    TextSpan(
                                        text: ' Terms & Privacy Policy',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                            color: Colors.white,
                                            decoration: TextDecoration.none)),
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
              ],
            ),
          ),
          onWillPop: () {
            return moveToLastScreen();
          }
      ),
    );
  }

  moveToLastScreen() {
    Navigator.pop(context, true);
  }

  moveToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MainScreen();
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
