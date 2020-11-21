import 'dart:io';

import 'package:detailsprod/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  String authorName, title, desc;
  File selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  upload() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      StorageReference firebasestoageRef = FirebaseStorage.instance
          .ref()
          .child("blog images")
          .child("${randomAlphaNumeric(9)}.jpg");
      final StorageUploadTask task = firebasestoageRef.putFile(selectedImage);
      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is url $downloadUrl");
      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "descrpition": desc
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: GestureDetector(
              onTap: () {
                upload();
              },
              child: Icon(
                Icons.file_upload,
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: selectedImage != null
                        ? Container(
                            height: 150,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                )))
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)),
                            height: 150,
                            child: Center(
                                child: Icon(Icons.add_a_photo,
                                    color: Colors.black45))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) {
                      authorName = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12),
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Desc'),
                    onChanged: (value) {
                      desc = value;
                    },
                  ),
                )
              ],
            ),
    );
  }
}
