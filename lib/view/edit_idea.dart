import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:light_notes/bloc/note/bloc/note_bloc.dart';
import 'package:light_notes/components/regular_text.dart';
import 'package:light_notes/enum/status_enum.dart';
import 'package:light_notes/model/note_model.dart';
import 'package:light_notes/view/home.dart';

class EditIdeaPage extends StatefulWidget {
  const EditIdeaPage({super.key, required this.note});

  final NoteModel? note;

  static const String routeName = '/note';

  @override
  State<EditIdeaPage> createState() => _EditIdeaPageState();
}

class _EditIdeaPageState extends State<EditIdeaPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.note!.title;
    _contentController.text = widget.note!.content;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state.status == StatusEnum.loading) {
          EasyLoading.show(status: 'Loading...');
        }
        if (state.status == StatusEnum.failure) {
          EasyLoading.showToast(state.error.toString());
        }
        if (state.status == StatusEnum.success) {
          EasyLoading.dismiss();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      child: Scaffold(
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
                controller: _titleController,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null, // Allows for unlimited lines
                  expands: true, // Allows the text field to expand vertically
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
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
                              context.read<NoteBloc>().add(
                                UpdateNoteEvent(
                                  id: widget.note!.id,
                                  title: _titleController.text,
                                  content: _contentController.text,
                                ),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();
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
      ),
    );
  }
}
