import 'package:flutter/material.dart';
import 'package:light_notes/components/card_notes.dart';
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
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              CardNotes(
                title: 'New Product Idea Design 1',
                description:
                    'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement.'
                    '\n\n'
                    'There will be a choice to select what kind of notes that user needed, so the experience while taking notes can be unique based on the needs.',
              ),
              CardNotes(
                title: 'New Product Idea Design 2',
                description:
                    'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement.'
                    '\n\n'
                    'There will be a choice to select what kind of notes that user needed, so the experience while taking notes can be unique based on the needs.',
              ),
            ],
          ),
          Row(
            children: [
              CardNotes(
                title: 'New Product Idea Design 3',
                description:
                    'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement.'
                    '\n\n'
                    'There will be a choice to select what kind of notes that user needed, so the experience while taking notes can be unique based on the needs.',
              ),
              CardNotes(
                title: 'New Product Idea Design 4',
                description:
                    'Create a mobile app UI Kit that provide a basic notes functionality but with some improvement.'
                    '\n\n'
                    'There will be a choice to select what kind of notes that user needed, so the experience while taking notes can be unique based on the needs.',
              ),
            ],
          ),
        ],
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
