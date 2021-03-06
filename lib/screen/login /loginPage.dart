import 'dart:async';
import 'dart:ui';
import 'package:movie_mock_list/screen/login%20/signIn.dart';
import 'package:movie_mock_list/screen/login%20/signup.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/const/constants.dart';
import 'package:movie_mock_list/widgets/blurEffect.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController controller;
  var _scrollController = ScrollController();
  Animation<double> animation;
  Timer _scrollAnimationTimer;
  int _count = 0;
  int _scrollCount = 0;
  var _icon = [Icons.ondemand_video, Icons.thumb_up_alt, Icons.check_circle];
  var _content = [
    'Discover  your new Favourite App',
    'Help them to show even better',
    'Track your shows and Movies',
    'Remember where you left off'
  ];
  var _opacity =1.0;
  var _blurOpacity =false;


  @override
  Widget build(BuildContext context) {
    _setUpTimerDuration();


    return Scaffold(
      body:  Container(
        height: double.infinity,
        color: Colors.black54,
        child: Stack(children: [

        SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            height: MediaQuery.of(context).size.height+100,
            width:  double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/login_background.jpg')))),
          ),
         Visibility(
            visible: _blurOpacity,
             child: BlurryEffect(0.0,0.0,Colors.grey)),
        Opacity(
      opacity: _opacity,
      child: Container(
        color: Colors.black.withOpacity(0.2),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 75),
              FadeTransition(
                opacity: animation,
                child: _createText(_scrollController, context,
                    _content[_count], _icon[_count]),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: RaisedButton(
                    onPressed: () {
                      navigationToSignUpPage();
                    },
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      GET_STARTED,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: ()
                  {
                    navigationToSignInPage();
                  },
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: AlREADY_HAD_ACCOUNT,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                        TextSpan(
                            text: ' $SIGN_IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ])
            ]),
      ),
        ),
      ]),
      )
    );
  }





  @override
  void initState() {
    super.initState();
    _setupScrollAnimation();
    _setupFadeTransitionAnimation();
    Timer.periodic(
      const Duration(seconds: 6),
          (Timer timer) => setState(() {
        _scrollCount = _scrollCount + 1;
      }),
    );
  }

  @override
  void dispose() {
    _scrollAnimationTimer.cancel();
  }

  /// fun to setup ScrollAnimation
  ///
  _setupScrollAnimation()
  {
    _scrollController = new ScrollController(
      // NEW
      initialScrollOffset: 10.0, // NEW
      keepScrollOffset: true, // NEW
    );
    _scrollAnimationTimer = new Timer.periodic(
      const Duration(seconds: 11),
          (Timer timer) => setState(
            () {
          _scrollCount = _count + 1;
          if (_count >= 2) {
            timer.cancel();
          } else {
            _count = _count + 1;
            _scrollController.jumpTo(_scrollCount.toDouble() * 10);
          }
        },

      ),
    );
  }

  /// fun to setup FadeTransitionAnimation
  ///
  _setupFadeTransitionAnimation(){
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_count < 2) {
          controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  /// fun to  setup SignUp Navigation

  Future navigationToSignUpPage()  async{
    setState(() {
      this._opacity =0.0;
      this._opacity=1.0;
    });
    var result =  await Navigator.of(context).push(PageRouteBuilder(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) => SingUp(),
        transitionsBuilder: (context, animation,
            secondaryAnimation, child) {
          var begin = Offset(1.5,0.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }));

    if(result  == true)
    {
      setState(() {
        this._opacity =1.0;

      });
    }
  }

  /// fun to  setup SignIn Navigation

  Future navigationToSignInPage()  async{
    setState(() {
      this._opacity =0.0;
      this._blurOpacity=true;

    });
    var result =  await Navigator.of(context).push(PageRouteBuilder(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) => SignIn(),
        transitionsBuilder: (context, animation,
            secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }));

    if(result  == true)
    {
      setState(() {
        this._opacity =1.0;
        this._blurOpacity =false;
      });
    }
  }

  /// fun for setting Timer for scroll when  the widgets created

   _setUpTimerDuration() {
    Timer(
      Duration(seconds: 1),
          () => _scrollController.jumpTo(_scrollCount.toDouble() * 10),
    );
  }

  /// fun to update text for fadetransition Property

  Widget _createText(ScrollController scrollController, BuildContext context,
      String data, IconData icon) {
    return Column(
      children: [
        RaisedButton(
            color: Colors.black,
            shape: CircleBorder(side: BorderSide.none),
            onPressed: () {},
            child: Icon(icon, size: 20, color: Colors.white)),
        SizedBox(height: 10),
        Text(
          '$data',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        )
      ],
    );
  }
}





