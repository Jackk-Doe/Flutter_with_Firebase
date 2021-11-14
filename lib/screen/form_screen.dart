// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Exam Record Form",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          /// Wrapped Column with SingleChildScrollView,
          /// to fix RenderFlex Overflowed,
          /// RenderFlex Overflowed : caused when Widget overflowed with things
          ///                         e.g. Keyboard overflowed with Widget
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "First name: ",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Last name: ",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Email: ",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Score: ",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "Save Data",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
