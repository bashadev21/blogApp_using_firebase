import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detailsprod/createblog.dart';
import 'package:detailsprod/details.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'blogApp  ',
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Blog()));
                },
                child: Icon(Icons.upload_file)),
          )
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('blogs').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      snapshot.data.documents
                                          .elementAt(index)['title'],
                                      snapshot.data.documents
                                          .elementAt(index)['imgUrl'],
                                      snapshot.data.documents
                                          .elementAt(index)['descrpition'],
                                    )));
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              child: Image.network(
                                snapshot.data.documents
                                    .elementAt(index)['imgUrl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            new Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  snapshot.data.documents
                                      .elementAt(index)['title'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
