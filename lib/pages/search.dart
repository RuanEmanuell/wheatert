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
  http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${myController.text}&units=metric&lang=pt_br&appid=insertyourapikeyhere"));

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


  var tempColor=Color.fromARGB(255, 73, 73, 73);
   

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        backgroundColor: tempColor,
        elevation:0,
        leading:IconButton(
          icon:Icon(Icons.arrow_back, color:Colors.white, size:40),
          onPressed:(){
            Navigator.pop(context);
          }
        )
      ),
      body:Container(
        color:tempColor,
        child:Center(
          child:Column(
            children:[
              dataLoaded ? Column(
              children:[
              Container(
              margin:EdgeInsets.only(left: 50),
              child:Row(
              children: [
                Text(appData.data["name"], style:TextStyle(
                fontSize:30,
                color:Colors.white
                 ) 
                ),
                Icon(Icons.location_on, color:Colors.white),
                Text(appData.data["sys"]["country"], style:TextStyle(
                  color:Colors.white
                )),
                Container(width: 50),
                 Image.network("http://openweathermap.org/img/wn/${appData.data["weather"][0]["icon"]}@2x.png")
               ]
              )
              ),
              Container(
              margin:EdgeInsets.only(left:75),
              child:Row(
                children:[
              Text("${appData.data["main"]["temp"].toStringAsFixed(0)}°C", style:TextStyle(
                color:Colors.white,
                fontSize:45
              ))
                ]
              )
              )
              ]
              ):Container(
                margin:EdgeInsets.only(top: 30),
                width:100,
                height:100,
                child: loading ? CircularProgressIndicator(
                  color:Colors.white
                ) : Text("")
              ),
              Container(height: 45),
              SizedBox(
              width:350,
              child:TextField(
                controller:myController,
                decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  hintText:"Search a city",
                  contentPadding:EdgeInsets.all(20)
                )
               )
              ),
              Container(height: 15),
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor:MaterialStateProperty.all(Colors.white)
                ),
                child:Text("Search", style:TextStyle(color: Colors.black)),
                onPressed:(){
                  if(myController.text!=""){
                  setState((){
                    dataLoaded=false;
                    loading=true;
                  });
                  getData();
                  Future.delayed(Duration(seconds:2), (){
                     setState((){
                      loading=false;
                      dataLoaded=true;
                      appData.data["main"]["temp"] < 15 ? tempColor=Colors.lightBlue : tempColor=Colors.orange;
                      });
                    });
                }
                }
              )
            ]
          )
        )
      )
      
    );
  }
}