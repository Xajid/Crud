import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'crud.dart';

class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  String _name;

  String number;
  getName(name) {
    this._name = name;
  }

  getNumber(numb) {
    this.number = numb;
  }

  CollectionReference _ref = FirebaseFirestore.instance.collection("mydata");

  final _nameController = TextEditingController();
  final _numController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder(
          stream: _ref.snapshots(),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data.docs[index].data() as Map;
                    return Card(
                      child: ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.black,
                            onPressed: () {
                              _nameController.text = doc['name'];
                              _numController.text = doc['number'];

                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        ListView(shrinkWrap: true, children: [
                                      TextField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Name',
                                          hintText: 'Enter Your Name',
                                        ),
                                        onChanged: (String name) {
                                          getName(name);
                                        },
                                      ),
                                      TextField(
                                        controller: _numController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Number',
                                          hintText: 'Enter Your Number',
                                        ),
                                        onChanged: (numb) {
                                          getNumber(numb);
                                        },
                                      ),
                                      RaisedButton(
                                        textColor: Colors.white,
                                        color: Colors.green,
                                        child: Text('Update '),
                                        onPressed: () {
                                          snapshot.data.docs[index].reference
                                              .update({
                                            "name": _name,
                                            "number": number,
                                          }).whenComplete(
                                                  () => Navigator.pop(context));
                                        },
                                      ),
                                      RaisedButton(
                                        textColor: Colors.white,
                                        color: Colors.red,
                                        child: Text('Delete '),
                                        onPressed: () {
                                          snapshot.data.docs[index].reference
                                              .delete();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            },
                          ),
                          title: Text(
                            doc['name'],
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc['number'],
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )),
                    );
                  });
            } else {
              return Text("Error!");
            }
          }),
      // RaisedButton(
      //   onPressed: () {},
      //   color: Colors.redAccent,
      //   child: Text('Delete'),
    );
  }
}
