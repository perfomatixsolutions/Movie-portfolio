import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlurryEffect extends StatelessWidget {
  final double opacity;
  final double blurry;
  final Color shade;  BlurryEffect(this.opacity,this.blurry,this.shade);    @override  Widget build(BuildContext context) {
    return Container(
      child: ClipRect(
        child:  BackdropFilter(
          filter:  ImageFilter.blur(sigmaX:10, sigmaY:10),
          child:  Container(
            width: double.infinity,
            height:  double.infinity,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}