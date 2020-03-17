import 'package:flutter/material.dart';
import 'package:sky_engine/_http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Images{
  int id;
  String name;
  String url;

  Images(this.id,this.name,this.url);
  Images.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['id'];
    name = parsedJson['title'];
    url = parsedJson['url'];
  }
}

class App extends StatefulWidget{
  createState(){
    return AppState();
  }
}

class AppState extends State<App>{
  int count = 0;
  Future<List<Images>> fetchImage() async{
    var result = await http.get('https://jsonplaceholde.typicode.com/photos/');
    var imageResults = json.decode(result.body);
    
    List<Images> images = [];
    for(var x in imageResults){
      Images image = Images(x["id"], x["name"], x["url"]);
      images.add(image);
    }
    return images;
  }

  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        title: Text("Let's see Images")),

        body: Container(
          child: Center(
            child: FutureBuilder(
              future: fetchImage(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                return ListView.builder(
                  itemCount: count,
                  itemBuilder:(BuildContext context, int index){
                    return ListTile(
                      title: Image.network(
                        snapshot.data[index].url
                      ),
                      subtitle: Text(snapshot.data[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize:24,height:2.0)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 25.0,vertical:5.0),
                    );
                  }
                );
              }
            )
          ),
        ),
        backgroundColor: Colors.blueAccent,
        floatingActionButton: FloatingActionButton(onPressed: (){
          setState(() {
            count += 1;
          });
        },
        child: Icon(Icons.add),
        ),
      ),
    );
  }
}

