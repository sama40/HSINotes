import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_notes/bloc/bloc/auth_bloc.dart';
import 'package:light_notes/bloc/note/bloc/note_bloc.dart';
import 'package:light_notes/enum/status_enum.dart';
import 'package:light_notes/view/edit_idea.dart';
import 'package:light_notes/view/input_idea.dart';
import 'package:light_notes/view/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<NoteBloc>().add(GetNoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    //final notesBox = Hive.box<Note>('notes');
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == StatusEnum.initial) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginPage.routeName,
            (_) => false,
          );
        }
      },

      child: Scaffold(
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            return GridView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes.elementAt(index);
                return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(5),
                  children: [
                    ListTile(
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
                      shape: Border.all(
                        color: const Color.fromARGB(255, 13, 2, 93),
                        width: .1,
                      ),
                      tileColor: Colors.grey[300],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditIdeaPage(note: state.notes[index])),
                        );
                      },
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
                                    Navigator.pop(context); // Close the dialog
                                    context.read<NoteBloc>().add(
                                      DeleteNoteEvent(state.notes[index].id),
                                    ); // Pass the ID of the note to delete
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
            );
          },
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                'press and hold note to delete',
                style: TextStyle(fontSize: 10, color: Colors.deepOrangeAccent),
              ),
              SizedBox(height: 50),
            ],
          ),
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
      ),
    );
  }
}
