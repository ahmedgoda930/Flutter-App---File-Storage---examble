import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> get getLocalPath async {
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  Future<File> getLocalFile() async {
    //local path for document folder
    String path = await getLocalPath;
    //file created in document path
    return File('$path/data.txt');
  }

  Future<File> wirteData(int d) async {
    File file = await getLocalFile();
    return file.writeAsString(d.toString());
  }

  Future<int> readData() async {
    try {
      var file = await getLocalFile();
      var content = await file.readAsString();
      return int.parse(content);
    } catch (e) {
      return 0;
    }
  }

  int data = 0;

  @override
  void initState() {
    super.initState();
    readData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Last Data = $data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            data++;
          });
          wirteData(data);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
