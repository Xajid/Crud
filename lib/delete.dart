import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  String _name;

  String number;
  CollectionReference _ref = FirebaseFirestore.instance.collection("mydata");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            onPressed: () {},
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
              // return Container(
              //   height: 700,
              //   child: ListView(
              //       children: documents
              //           .map((doc) => Card(
              //                 child: ListTile(
              //                   title: Text(doc['name']),
              //                   subtitle: Text(doc['number']),
              //                 ),
              //               ))
              //           .toList()),
              // );
            } else {
              return Text("Error!");
            }
          }),
    );
  }
}
