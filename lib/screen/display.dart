// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Exam Score Results"),
        ),
        body: StreamBuilder(

            /// Connect this StreamBuilder with Firebase Collection named "students"
            stream:
                FirebaseFirestore.instance.collection("students").snapshots(),

            /// Collection is stored in this <parameter>snapshot<parameter>
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              /// If collection is EMPTY or still READING
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              /// Else if collection is ready
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(document["score"]),
                        ),
                      ),
                      title: Text(
                        document["fname"] + " " + document["lname"],
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(document["email"]),
                    ),
                  );
                }).toList(),
              );
            }));
  }
}
