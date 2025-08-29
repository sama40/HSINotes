import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:light_notes/app/app.dart';

void main() async {
  // 1. Ensure Flutter bindings are initialized
  //WidgetsFlutterBinding.ensureInitialized();

  // 2. Get the application documents directory
  //final appDocumentDir = await getApplicationDocumentsDirectory();

  // 3. Initialize Hive and provide a path
  //Hive.init(appDocumentDir.path);

  // 4. Register the TypeAdapter
  //Hive.registerAdapter(NoteAdapter());

  // 5. Open the box
  //await Hive.openBox<Note>('notes');

  runApp(const MyApp());
}
