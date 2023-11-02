import 'package:flutter/material.dart';
import 'package:med/ui/hospital_needs.dart';


import 'package:provider/provider.dart';


class DirectorHomeScreen extends StatefulWidget {
  const DirectorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DirectorHomeScreen> createState() => _DirectorHomeScreenState();
}

class _DirectorHomeScreenState extends State<DirectorHomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notes = context.watch<HospitalNeeds>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital review'),
      ),
      body: notes.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          itemCount: notes.notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notes.notes[index].title),
              subtitle: Text(notes.notes[index].description),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  notes.deleteNote(notes.notes[index].id);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Note'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter title',
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      notes.addNote(
                        titleController.text,
                        descriptionController.text,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
