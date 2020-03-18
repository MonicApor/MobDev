import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ImageModel{
  int id;
  String url;
  String title;

  ImageModel(this.id,this.url,this.title);
  
  ImageModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }
}

class App extends StatefulWidget{
  createState(){
    return AppState();
  }
}

class AppState extends State<App>{
  int count = 0;
  
  Future<List<ImageModel>> fetchImage() async{
    var response = await http.get('https://jsonplaceholder.typicode.com/photos/');
    var imageModel = json.decode(response.body);
    
    List<ImageModel> images = [];
    for(var x in imageModel){
      ImageModel image = ImageModel(x["id"], x["url"], x["title"]);
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
                      subtitle: Text(snapshot.data[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize:24,height:2.0)),
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

// import 'package:flutter/material.dart';
 
// class App extends StatefulWidget{
//   createState(){
//     return AppState();
//   }
// }
 
// class AppState extends State<App>{
//   int count = 0;
//   Widget build(BuildContext context){
//     return MaterialApp(
//       home: Scaffold(appBar: AppBar(
//         title: Text("Let's see Images")),
//         body: Text("Clicked $count times"),
//         floatingActionButton: FloatingActionButton(onPressed: (){
//           setState(() {
//             count += 1;
//           });
//         },
//         child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }


