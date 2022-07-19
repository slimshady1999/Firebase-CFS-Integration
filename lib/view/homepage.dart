import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'noteEntry.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection("Notes");

  // Firebase Update Method //

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _titleController.text = documentSnapshot["Title"];
      _descriptionController.text = documentSnapshot["Description"];

      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            const Padding(padding: EdgeInsets.all(10));
            return Container(
              height: MediaQuery.of(context).size.height / 1.80,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(label: Text("Title")),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(label: Text("Description")),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () {
                        final title = _titleController.text;
                        final description = _descriptionController.text;

                        _notes.doc(documentSnapshot.id).update(
                            {"Title": title, "Description": description});
                      },
                      child: const Text("Update"))
                ],
              ),
            );
          });
    }
  }

  // Firebase Create Data Method //

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _titleController.text = documentSnapshot["Title"];
      _descriptionController.text = documentSnapshot["Description"];

      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.80,
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        label: Text("Description"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () async {
                        final title = _titleController.text;
                        final description = _descriptionController.text;
                        await _notes
                            .add({"Title": title, "Description": description});
                      },
                      child: const Text("Create"))
                ]),
              ),
            );
          });
    }
  }

  // Firebase Deleting Data Method //

  Future<void> _delete(String notesId) async {
    await _notes.doc(notesId).delete();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: const Text("Firebase Cloud Firestore",
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (contex) => const NoteEntry()));

            _create();
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: _notes.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Card(
                            shadowColor: Colors.black,
                            elevation: 14,
                            child: ListTile(
                              title: Text(documentSnapshot["Title"]),
                              subtitle: Text(documentSnapshot["Description"]),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _update(documentSnapshot);
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          _delete(documentSnapshot.id);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (streamSnapshot.hasError) {
                    return const Center(
                        child: Text("No Data Found! Please Add."));
                  }
                  return const CircularProgressIndicator(color: Colors.blue);
                },
              ),
            ),
          ]),
        ));
  }
}
