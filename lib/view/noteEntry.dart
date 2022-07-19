import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedb/view/homepage.dart';
import 'package:flutter/material.dart';

class NoteEntry extends StatefulWidget {
  const NoteEntry({super.key});

  @override
  State<NoteEntry> createState() => _NoteEntryState();
}

class _NoteEntryState extends State<NoteEntry> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final CollectionReference notes =
        FirebaseFirestore.instance.collection("Notes");

    Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        titleController.text = documentSnapshot["Title"];
        descriptionController.text = documentSnapshot["Description"];
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text("Add Note"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 50,
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft, child: Text("Description")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 20,
                controller: descriptionController,
                decoration: const InputDecoration(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final description = descriptionController.text;
                  await notes.add({"Title": title, "Description": description});

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (contex) => const HomePage()));
                },
                child: const Text("Create"))
          ]),
        ));
  }
}
