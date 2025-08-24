import 'package:flutter/material.dart';
import 'package:light_notes/components/regular_text.dart';
import 'package:light_notes/view/input_idea.dart';

class Home0Page extends StatefulWidget {
  const Home0Page({super.key});

  @override
  State<Home0Page> createState() => _Home0PageState();
}

class _Home0PageState extends State<Home0Page> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/lamp.png', width: 250, height: 250),
            const SizedBox(height: 20),
            const RegularText(
              text: "Start Your Journey",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Every big step start with small step.\n'
                'Notes your first idea and start\n'
                'your journey!',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/arrow.png', // Replace with your image path
              width: 300,
              height: 100,
            ),
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
    );
  }
}
