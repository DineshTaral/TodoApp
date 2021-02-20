import 'package:flutter/material.dart';
import 'package:flutter_todo/Constants/ColorsConstants.dart';
import 'package:flutter_todo/Screens/ToDoListScreen.dart';
import 'package:sizer/sizer_util.dart';
import 'package:sizer/sizer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(                           //return LayoutBuilder
        builder: (context, constraints) {
      return OrientationBuilder(                  //return OrientationBuilder
        builder: (context, orientation) {
          //initialize SizerUtil()
          SizerUtil().init(constraints, orientation);  //initialize SizerUtil
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'To-Do App',
            theme: ThemeData(
              textTheme: TextTheme(
                headline1: TextStyle(fontSize: 12.0.sp,color: ColorsConstants.WHITE_TEXT_COLOR),
                headline2: TextStyle(fontSize: 18.0.sp,fontWeight: FontWeight.bold,color: ColorsConstants.WHITE_TEXT_COLOR),
                headline3: TextStyle(fontSize: 12.0.sp,fontWeight: FontWeight.bold,color: ColorsConstants.WHITE_TEXT_COLOR),
              )
            ),
            home: ToDoListScreen(),
          );
        },
      );
    });
  }
}

