import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimentions.dart';

class ResponsiveLayout extends StatelessWidget{
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout
      ({Key? key, required this.webScreenLayout, required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        //web screen
        if(constraints.maxWidth > WebScreenSize){
          return webScreenLayout;
        }
        return mobileScreenLayout;
        //mobile screen
      },
    );
  }

}