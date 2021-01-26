import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future _futureGetPath;
  List<dynamic> listImagePath = List<dynamic>();
  var _permissionStatus;

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    _futureGetPath = _getPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: FutureBuilder(
              future: _futureGetPath,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var dir = Directory(snapshot.data);
                  if (_permissionStatus) {
                    _fetchFiles(dir);
                  }
                  return Expanded(
                      flex: 20,
                      child: ListView(
                        children: _getListImg(listImagePath),
                      ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _listenForPermissionStatus() async {
    final status = await Permission.storage.request().isGranted;
    setState(() => _permissionStatus = status);
  }

  Future<String> _getPath() async {
    final appdir = await await getExternalStorageDirectory();
    String path = appdir.path + '/Pictures/';
    return path;
  }

  _fetchFiles(Directory dir) {
    List<dynamic> listImage = List<dynamic>();
    dir.list().forEach((element) {
      RegExp regExp =
          new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp)", caseSensitive: false);
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePath = listImage;
      });
    });
  }

  List<Widget> _getListImg(List<dynamic> listImagePath) {
    List<Widget> listImages = List<Widget>();
    for (var imagePath in listImagePath) {
      listImages.add(
        Container(
          padding: const EdgeInsets.all(8),
          child: Image.file(imagePath, fit: BoxFit.cover),
        ),
      );
    }
    if (listImagePath.length == 0) {
      List<Widget> message = [];
      message.add(
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 150,
          child: Center(
            child: Text(
              'Add Picture',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      );
      return message;
    } else {
      return listImages;
    }
  }
}
