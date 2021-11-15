// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/student.dart';
import 'package:form_field_validator/form_field_validator.dart';

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

  /// Prepare Firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  /// Create Collection name "students" to store Student data from <field>myStudent<field>,
  /// to Firebase
  CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection("students");

  @override
  void initState() {
    super.initState();
    // startConnectionToFirebase();
  }

  // void startConnectionToFirebase() async {
  //   await Firebase.initializeApp();
  // }

  @override
  Widget build(BuildContext context) {
    /*
    FutureBuilder : create a widget that builds itself based on the lastest
                    [snapshot] of interaction with the [Future] object
    */
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          /*
          Error : check if there's error when try to connect with Firebase
          */
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error with Firebase connection"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          /*
          Connection succeeded : if connection succeeded
          */
          if (snapshot.connectionState == ConnectionState.done) {
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
                            validator: RequiredValidator(
                                errorText: "First name require!"),
                            // Assign Text form this TextFormField to Student's attribute
                            onSaved: (String? fname) =>
                                myStudent.fname = fname),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Last name: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                            validator: RequiredValidator(
                                errorText: "Last name require!"),
                            // Assign Text form this TextFormField to Student's attribute
                            onSaved: (String? lname) =>
                                myStudent.lname = lname),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Email: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Email require!"),
                              EmailValidator(errorText: "Wrong Email format!"),
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            //Assign Text form this TextFormField to Student's attribute
                            onSaved: (String? email) =>
                                myStudent.email = email),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Score: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                            validator:
                                RequiredValidator(errorText: "Score require!"),
                            keyboardType: TextInputType.number,
                            // Assign Text form this TextFormField to Student's attribute
                            onSaved: (String? score) =>
                                myStudent.score = score),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              "Save Data",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              /// Check validation of TextFormField
                              if (formKey.currentState!.validate()) {
                                // Triger all onSaved() of Form widget that this FormState attrached to
                                formKey.currentState?.save();

                                // Store data from form (in JSON)
                                await _studentCollection.add({
                                  "fname": myStudent.fname,
                                  "lname": myStudent.lname,
                                  "email": myStudent.email,
                                  "score": myStudent.score
                                });

                                // Reset all contexts in form
                                formKey.currentState?.reset();
                              }
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

          /*
          Connection loading : if still connecting to Firebase,
                               show loading Widget
          */
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
