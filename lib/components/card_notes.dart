import 'package:flutter/material.dart';

class CardNotes extends StatelessWidget {
  final String title;
  final String description;

  const CardNotes({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListTile(
          title: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            description,
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
                      //_deleteNote(index);
                      //Navigator.pop(context);
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
