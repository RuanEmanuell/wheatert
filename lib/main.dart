import 'package:flutter/material.dart';
import "dart:async";
import 'package:http/http.dart' as http;
import 'package:flutter_mobx/flutter_mobx.dart';
import "../stores/appdata.dart";
import 'pages/loading.dart';
import "pages/home.dart";




void main(){
  runApp(MaterialApp(
    initialRoute:"/loading",
    routes:{
      "/loading":(context)=>LoadingScreen(),
      "/home":(context)=>HomeScreen()
    }
   )
  );
}
