import "package:flutter/material.dart";
import "../main.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_mobx/flutter_mobx.dart';


class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation:0,
        actions:[
          IconButton(
            icon:Icon(Icons.search, color:Colors.black, size:40),
            onPressed:(){
              Navigator.pushNamed(context, "/search");
            }
          )
        ]
      ),
      body:Container(
        color:Colors.white,
        child:Center(
          child:Text("cu")
        )
      )
      
    );
  }
}