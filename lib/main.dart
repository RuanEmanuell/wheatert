import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';



void main(){
  runApp(MaterialApp(
    home:HomePage()
    )
  );
}

class HomePage extends StatefulWidget{
  @override
  _HomePage createState()=>_HomePage();
}

class _HomePage extends State<HomePage>{

  bool changeColor=false;
  bool bigger=false;
  

  void update(){
    setState((){
       changeColor=!changeColor;
       bigger=!bigger;
    });
  }



  @override
  Widget build(BuildContext context){  

    return Scaffold(
      floatingActionButton:FloatingActionButton(
        onPressed:(){
         update();
        }
      ),
      body:AnimatedContainer(
        curve:Curves.bounceOut,
        width:bigger?400:200,
        height:bigger?400:200,
        duration:Duration(milliseconds: 800),
        decoration:BoxDecoration(
           color:changeColor?Colors.red:Colors.blue,
          borderRadius: BorderRadius.circular(20)
        )
      ),
      

    );
  }
}