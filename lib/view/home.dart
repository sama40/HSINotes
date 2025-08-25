import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:light_notes/model/note.dart';
import 'package:light_notes/view/input_idea.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notesBox = Hive.box<Note>('notes');
    return Scaffold(
      body: ListView.builder(
        itemCount: notesBox.length,
        itemBuilder: (context, index) {
          final note = notesBox.getAt(index);
          if (note == null) return const SizedBox.shrink();
          return Expanded(
            child: Card(
              child: ListTile(
                title: Text(
                  note.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  note.content,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                ),
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Note?'),
                      content: const Text(
                        'Are you sure you want to delete this note?',
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              notesBox.deleteAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InputIdeaPage()),
          );
        },
        elevation: 100,
        backgroundColor: const Color.fromARGB(255, 13, 2, 93),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
