import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class selecttype extends StatefulWidget {
  static String id = ' selecttype';
  @override
  _selecttypeState createState() => _selecttypeState();
}

class _selecttypeState extends State<selecttype> {
  File imageCamera;
  File imageGallery;
  File _image;
  Future getImageCamera() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        _image = File(image.path);
        imageCamera = File(image.path);
      }
    });
  }

  Future getImageGallery() async {
    final PickedFile file =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _image = File(file.path);
        imageGallery = File(file.path);
      });
    }
  }

  Future<void> saveImage(BuildContext context) async {
    if (imageCamera != null) {
      final cameraImage = await getApplicationDocumentsDirectory();
      print(cameraImage.path);
      final fileName = basename(imageCamera.path);
      final File savedimage =
          await imageCamera.copy('${cameraImage.path}/$fileName');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text('Image Saved')),
            );
          });
    } else if (imageGallery != null) {
      final galleryImage = await getExternalStorageDirectory();
      final fileName = basename(imageGallery.path);
      final File savedimage =
          await imageGallery.copy('${galleryImage.path}/Pictures/$fileName');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text('Image Saved')),
            );
          });
    }
    setState(() {
      imageCamera = null;
      imageGallery = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text(
          'Pick Image',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Container(
                    color: Colors.grey,
                    child: _image == null
                        ? Icon(
                            Icons.image,
                            size: 220,
                          )
                        : Image.file(
                            _image,
                            fit: BoxFit.cover,
                          )),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12 - 30,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height / 10 - 30,
                  onPressed: () {
                    getImageCamera();
                  },
                  color: Colors.lightBlueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(Icons.camera, size: 30),
                      ),
                      Container(
                        child: Text(
                          "Camera",
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height / 10 - 30,
                  onPressed: () {
                    getImageGallery();
                  },
                  color: Colors.lightBlueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.photo_album,
                          size: 30,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Gallery",
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.8,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    height: MediaQuery.of(context).size.height / 10 - 30,
                    onPressed: () {
                      saveImage(context);
                      Timer(Duration(milliseconds: 2000), () {
                        Navigator.pop(context);
                        setState(() {
                          _image = null;
                        });
                      });
                    },
                    color: Colors.lightBlueAccent,
                    child: Container(
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 25),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
