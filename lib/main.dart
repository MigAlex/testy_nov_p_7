import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    title: 'Input&Output',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path; //home/directory:text
  }

  Future<File> get _localFile async {
    final path = await _localPath; //umieszczamy tu nasza sciezke
    return new File(
        '$path/data.txt'); //zwrot ze sciezka zawierajaca plik data.txt
  }

  //write and read from file
  Future<File> writeData(String message) async {
    final file = await _localFile;

    //write to file
    return file.writeAsString('$message');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      //read
      String data = await file
          .readAsString(); //akcesuje do pliku otrzymanego z _localFile i odczytuje go jako String
      return data;
    } catch (e) {
      return "Nothing saved yet";
    }
  }
}
