import 'dart:async';
import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_mobx/flutter_mobx.dart';
import "../main.dart";
import "../stores/appdata.dart";
import 'package:geolocator/geolocator.dart';


final appData=AppData();

bool dataLoaded=false;
bool loading=false;

String apikey="INSERT YOUR API KEY HERE";

var lat;
var lon;



Future getLocation() async{
  LocationPermission permission=await Geolocator.requestPermission();
  Position position=await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );
  lat=position.latitude;
  lon=position.longitude;
}



Future getData() async{
  http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apikey}&units=metric"));

  if(response.statusCode==200){
    appData.data=response.body;
    appData.data=jsonDecode(appData.data);

  }

}


class SearchScreen extends StatefulWidget{
  @override
  _SearchScreen createState()=>_SearchScreen();
}

class _SearchScreen extends State<SearchScreen>{ 


  var tempColor=Color.fromARGB(255, 73, 73, 73);

  void initState(){
    super.initState();

    setState((){
      dataLoaded=false;
      loading=true;
    });

    getLocation();


    Future.delayed(Duration(seconds: 5),(){
      getData();
    });


     Future.delayed(Duration(seconds:7),(){
      setState((){
      loading=false;
      dataLoaded=true;

      appData.data["main"]["temp"]<=14.99 ? tempColor=Color.fromARGB(255, 152, 197, 255):tempColor;
      appData.data["main"]["temp"]>15 ?tempColor=Color.fromARGB(255, 90, 159, 248):tempColor;
      appData.data["main"]["temp"]>25 ? tempColor=Color.fromARGB(255, 253, 186, 0):tempColor;
      appData.data["main"]["temp"]>32 ? tempColor=Color.fromARGB(255, 255, 123, 0):tempColor;

      });
     });

  


  
    
  }
   

  @override
  Widget build(BuildContext context){

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    double barHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body:AnimatedContainer(
        duration:Duration(seconds: 1),
        color:tempColor,
        child:Center(
          child:Column(
            children:[
              dataLoaded ? Column(
              children:[
              Center(child: Container(
              margin:EdgeInsets.only(top: barHeight+20, left:20),
              child:Row(
                 mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${appData.data["main"]["temp"].toStringAsFixed(0)}°C", style:TextStyle(
                color:Colors.white,
                fontSize:80
              )),
                Container(
                margin:EdgeInsets.only(left: 18),
                child:Image.network("http://openweathermap.org/img/wn/${appData.data["weather"][0]["icon"]}@2x.png")
                )
               ]
              )
              )
              ),
              Center(
              child:Container(
              margin:EdgeInsets.only(bottom:height-300),
              child:Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children:[
                 Text(appData.data["name"], style:TextStyle(
                fontSize:30,
                color:Colors.white
                 ) 
                ),
                Icon(Icons.location_on, color:Colors.white),
                Text(appData.data["sys"]["country"], style:TextStyle(
                  color:Colors.white
                )),
                ]
              )
              )
              ),
              Column(
              mainAxisSize: MainAxisSize.max,
              children:[
                Text("WheateRT", style:TextStyle(
                fontSize:30,
                color:Colors.white
                 ) 
                ),
                Text("by Ruan Emanuell", style:TextStyle(
                fontSize:20,
                color:Colors.white
                 ) 
                ),
              ]
              )
              ]
              ):Container(
                margin:EdgeInsets.only(top: height/2-20),
                width:100,
                height:100,
                child: loading ? CircularProgressIndicator(color:Colors.white) : Text("")
              )
            ]
          )
        )
      )
      
    );
  }
}