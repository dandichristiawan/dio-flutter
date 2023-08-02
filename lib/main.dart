import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(const MyApp());

// ignore: prefer_typing_uninitialized_variables
var jsonList;

void getHttp() async {
  var response =
      await Dio().get("https://protocoderspoint.com/jsondata/superheros.json");
  jsonList = response.data["superheros"] as List;
}

void postHttp() async {
  try {
    var response = await Dio().post("https://reqres.in/api/users",
        data: {"name": "dandi", "job": "co-leader"});
    print("Response : ${response.data}");
  } catch (e) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Dio test'),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.network(
                    jsonList[index]['url'],
                    fit: BoxFit.fill,
                    width: 50,
                    height: 150,
                  ),
                ),
                titleTextStyle: const TextStyle(
                    fontFamily: 'Aftika',
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0,
                    color: Colors.black),
                subtitleTextStyle: const TextStyle(
                    fontFamily: 'Aftika',
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                    color: Colors.grey),
                title: Text(jsonList[index]['name']),
                subtitle: Text(jsonList[index]['power']),
              ),
            );
          },
          itemCount: jsonList == null ? 0 : jsonList.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            postHttp();
          },
          tooltip: 'Get',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
