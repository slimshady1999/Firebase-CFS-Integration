/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebaseHelper/cloud_firestore.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _notesData =
      FirebaseFirestore.instance.collection("Notes");

  // Firebase CRUD operation //

  Future<void> addData() async {
    CollectionReference notes = _notesData.collection("Notes");
    await notes.doc("NotesData").set({
      "Title": "Welcome!",
      "Description":
          "This is a default Note, choose to delete or save? your call!",
    });
  }

  // Query Data from firestore //

  // Future<void> readData() async {
  //   CollectionReference users = _notesData.collection("Notes");
  //   QuerySnapshot getAllData = await users.get();
  //   for (var result in getAllData.docs) {
  //     debugPrint("${result.data()}");
  //   }
  // }

  // Add data to firestore //
  Future<void> update() async {
    CollectionReference notes = _notesData.collection("Notes");
    await notes.doc("usernames").update({
      "Title": "$_titleController",
      "Description": "$_descriptionController",
    });
  }

  // Add data to firestore //
  Future<void> deleteData() async {
    CollectionReference notes = _notesData.collection("users");
    await notes.doc("usernames").delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Expanded(
            child: StreamBuilder(
          stream: _notesData,
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {}
          },
        ))
      ])),
    );
  }
}
*/