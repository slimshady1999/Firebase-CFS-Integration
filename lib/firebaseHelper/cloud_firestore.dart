 /*
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

TextEditingController _titleController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();

class FireStoreHelper {
  FirebaseFirestore noteData = FirebaseFirestore.instance;

  // Add data to firestore //
  Future<void> addData() async {
    CollectionReference notes = noteData.collection("notes");
    await notes.doc("usernames").set({
      "Title": "jax",
      "Description": "shady",
    });
  }

  // Query Data from firestore //

  Future<void> readData() async {
    CollectionReference users = noteData.collection("users");
    QuerySnapshot getAllData = await users.get();
    for (var result in getAllData.docs) {
      debugPrint("${result.data()}");
    }
  }

  // Add data to firestore //
  Future<void> update() async {
    CollectionReference users = noteData.collection("users");
    await users.doc("usernames").update(
        {"name1": "gift", "name2": "well", "name3": "stones", "name4": "bond"});
  }

  // Add data to firestore //
  Future<void> deleteData() async {
    CollectionReference users = noteData.collection("users");
    await users.doc("usernames").delete();
  }

  // Subscribe to streaming events //
}
*/