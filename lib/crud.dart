import 'package:crud/delete.dart';
import 'package:crud/read.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _name;

  String number;

  getName(name) {
    this._name = name;
  }

  getNumber(numb) {
    this.number = numb;
  }

  addData() {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("mydata").doc(_name);

    Map<String, dynamic> _data = {
      "name": _name,
      "number": number,
    };
    docRef.set(_data).whenComplete(() {
      print("$_name");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Crud App",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
                onChanged: (String name) {
                  getName(name);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                maxLength: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: 'Enter number',
                ),
                onChanged: (numb) {
                  getNumber(numb);
                },
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('ADD DATA'),
              onPressed: () {
                addData();
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.amber,
              child: Text('Read Data'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Read()));
              },
            )
          ],
        ));
  }
}
