import 'package:flutter/material.dart';
import 'package:light_notes/components/regular_text.dart';
import 'package:light_notes/view/home.dart';

class InputIdeaPage extends StatelessWidget {
  const InputIdeaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        leadingWidth: 100,
        leading: TextButton.icon(
          label: const Text("Back"),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'New Products Ideas',
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            Expanded(
              child: TextFormField(
                maxLines: null, // Allows for unlimited lines
                expands: true, // Allows the text field to expand vertically
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText:
                      'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement.'
                      '\n\n'
                      'There will be a choice to select what kind of notes that user needed, so the experience while taking notes can be unique based on the needs.',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    showCloseIcon: true,
                    closeIconColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          label: const RegularText(text: "Mark as Finished"),
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                        ),
                        TextButton.icon(
                          label: const RegularText(
                            text: "Delete Note",
                            color: Colors.red,
                          ),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                    duration: Duration(minutes: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 13, 2, 93),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Icon(Icons.more_horiz, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
