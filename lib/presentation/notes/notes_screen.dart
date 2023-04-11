import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app_clone/presentation/notes/components/note_item.dart';
import 'package:note_app_clone/presentation/notes/components/order_section.dart';
import 'package:note_app_clone/presentation/notes/notes_event.dart';
import 'package:note_app_clone/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Your note',
          style: TextStyle(
            fontSize: 32,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.onEvent(const NotesEvent.toggleOrderSection());
            },
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isSaved = await context.push('/addEditScreen');

          if (isSaved != null && isSaved) {
            viewModel.onEvent(const NotesEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.isOrderSectionVisible
                ? OrderSection(
                    noteOrder: state.noteOrder,
                    onOrderChanged: (noteOrder) {
                      viewModel.onEvent(NotesEvent.changeOrder(noteOrder));
                    },
                  )
                : Container(),
          ),
          ...state.notes
              .map((note) => GestureDetector(
                    onTap: () async {
                      bool? isSaved = await context.push('/addEditScreen');

                      if (isSaved != null && isSaved) {
                        viewModel.onEvent(const NotesEvent.loadNotes());
                      }
                    },
                    child: NoteItem(
                      note: note,
                      onDeleteTap: () {
                        viewModel.onEvent(NotesEvent.deleteNote(note));

                        final snackBar = SnackBar(
                          content: const Text('Note is deleted.'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              viewModel.onEvent(const NotesEvent.restoreNote());
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  ))
              .toList(),
        ]),
      ),
    );
  }
}
