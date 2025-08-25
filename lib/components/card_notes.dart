import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:light_notes/model/note.dart';

class CardNotes extends StatefulWidget {
  final String title;
  final String description;
  final int index;

  const CardNotes({
    super.key,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  State<CardNotes> createState() => _CardNotesState();
}

class _CardNotesState extends State<CardNotes> {
  @override
  Widget build(BuildContext context) {
    final notesBox = Hive.box<Note>('notes');
    return Expanded(
      child: Card(
        child: ListTile(
          title: Text(
            widget.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            widget.description,
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
                        notesBox.deleteAt(widget.index);
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
  }
}
