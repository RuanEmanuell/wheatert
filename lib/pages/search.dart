import "package:flutter/material.dart";
import "../main.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_mobx/flutter_mobx.dart';
import "../stores/appdata.dart";

final appData=AppData();

bool dataLoaded=false;
bool loading=false;

final myController=TextEditingController();


Future getData() async{
  http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${myController.text}&units=metric&lang=pt_br&appid=e2f1e6118e15e3bd5df31fcd07c3bdfa"));

  if(response.statusCode==200){
    appData.data=response.body;
    print(appData.data);
    appData.data=jsonDecode(appData.data);
  }else{
    print(response.statusCode);
  }


}


class SearchScreen extends StatefulWidget{
  @override
  _SearchScreen createState()=>_SearchScreen();
}

class _SearchScreen extends State<SearchScreen>{ 

   

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.white,
        elevation:0,
        leading:IconButton(
          icon:Icon(Icons.arrow_back, color:Colors.black, size:40),
          onPressed:(){
            Navigator.pop(context);
          }
        )
      ),
      body:Container(
        color:Colors.white,
        child:Center(
          child:Column(
            children:[
              dataLoaded ? Column(
              children:[
              Text(appData.data["name"]),
              Text(appData.data["sys"]["country"]),
              Text("${appData.data["main"]["temp"].toStringAsFixed(0)}°C"),
              Image.network("http://openweathermap.org/img/wn/${appData.data["weather"][0]["icon"]}@2x.png")
              ]
              ):Container(
                child: loading ? CircularProgressIndicator() : Text("")
              ),
              TextField(
                controller:myController
              ),
              ElevatedButton(
                child:Text("search"),
                onPressed:(){
                  setState((){
                    dataLoaded=false;
                    loading=true;
                  });
                  getData();
                  Future.delayed(Duration(seconds:2), (){
                     setState((){
                      loading=false;
                      dataLoaded=true;
                      });
                    });
                }
              )
            ]
          )
        )
      )
      
    );
  }
}