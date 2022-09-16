import 'package:flutter/material.dart';
import "dart:async";
import 'package:http/http.dart' as http;
import 'package:flutter_mobx/flutter_mobx.dart';
import "../stores/appdata.dart";
import "pages/search.dart";




void main(){
  runApp(MaterialApp(
    initialRoute:"/search",
    routes:{
      "/search":(context)=>SearchScreen()
    }
   )
  );
}
