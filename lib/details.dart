import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String name, img, desc;
  Details(this.name, this.img, this.desc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Row(
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
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            child: Text(name),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              width: 350,
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: Text(desc),
          )
        ],
      ),
    );
  }
}
