import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

var stringResponse;
var listResponse;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future apicall() async{
    http.Response response;
    response =await http.get(Uri.parse("https://api.sampleapis.com/futurama/characters"));
    if(response.statusCode == 200){
      setState(() {
        //stringResponse = response.body;
        listResponse = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Articles"),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return Container(
          margin:EdgeInsets.all(25),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20),
              child: Image.network(listResponse[index]['images']['main'] )
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text("News ID : "+listResponse[index]['id'].toString(),style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text("Name : "+listResponse[index]['name']['first'].toString()+" "+listResponse[index]['name']['middle'].toString()+" "+listResponse[index]['name']['last'].toString(),style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text("Species : "+listResponse[index]['species'].toString(),style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text("Gender : "+listResponse[index]['gender'].toString(),style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text("Age : "+listResponse[index]['age'].toString(),style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Text("Occupation : "+listResponse[index]['occupation'].toString(),style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 2, 30, 20),
                child: Text("Saying : "+listResponse[index]['sayings'][0].toString(),style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
      itemCount: listResponse==null ? 0 : listResponse.length,
      )
    );
  }
}
