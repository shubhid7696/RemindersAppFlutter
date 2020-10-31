import 'package:flutter/material.dart';

class SizedImageWidget extends StatelessWidget {
  final double height ;
  final double width ;
  final String imageUrl;

  SizedImageWidget([this.height, this.width, this.imageUrl]);

  @override
  Widget build(BuildContext context) {
    return Container(
      // uncomment the line below to add border
      // padding: EdgeInsets.only(top: 16.0),
      width: height,
      height: height,
      // decorate border using line below
//      decoration: BoxDecoration(color: Colors.white),
      child: Image.asset(imageUrl,height: height,width: height,),
    );
  }
}