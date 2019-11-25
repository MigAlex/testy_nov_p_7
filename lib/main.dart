import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

void main() async{

  var data = await readData(); 
  if(data != null){
    String message = await readData();
    print(message);
  }

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
  var _enterDataField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read and Write'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(
              labelText: 'Write text you want to be read'
            ),
          ),
          subtitle: FlatButton(
            onPressed: (){
              //save to file
              writeData(_enterDataField.text);
            },
            child: Column(
              children: <Widget>[
                Text('Save Data'),
                Padding(padding: const EdgeInsets.all(15),),
                FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context, AsyncSnapshot<String> data){
                      if(data.hasData != null){
                        return Text(
                          data.data.toString(),
                          style: TextStyle(color: Colors.amberAccent),
                        );
                      } else {
                        Text('No data Saved');
                      }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path; //home/directory:text
  }

  Future<File> get _localFile async {
    final path = await _localPath; //umieszczamy tu nasza sciezke
    return new File('$path/data.txt'); //zwrot ze sciezka zawierajaca plik data.txt
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

