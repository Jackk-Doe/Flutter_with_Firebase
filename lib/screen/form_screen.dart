// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/student.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  /// Use to check (Validate) state of Form Widget,
  /// Also use to check Form widget current state
  final formKey = GlobalKey<FormState>();

  /// Assign each Student Object's attribute with each matching TextFormField,
  /// instead of using Controller, this way is easier
  /// when need have to dealing with multiple TextFormField
  Student myStudent = Student();

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
          key: formKey,

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
                TextFormField(
                    // Assign Text form this TextFormField to Student's attribute
                    onSaved: (String? fname) => myStudent.fname = fname),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Last name: ",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                    // Assign Text form this TextFormField to Student's attribute
                    onSaved: (String? lname) => myStudent.lname = lname),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Email: ",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                    //Assign Text form this TextFormField to Student's attribute
                    onSaved: (String? email) => myStudent.email = email),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Score: ",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                    // Assign Text form this TextFormField to Student's attribute
                    onSaved: (String? score) => myStudent.score = score),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "Save Data",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      // Triger all onSaved() of Form widget that this FormState attrached to
                      formKey.currentState?.save();

                      // Test printing
                      print("${myStudent.fname}");
                      print("${myStudent.lname}");
                      print("${myStudent.email}");
                      print("${myStudent.score}");
                    },
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
