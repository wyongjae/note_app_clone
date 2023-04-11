import 'package:flutter/material.dart';
import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/use_case/use_cases.dart';
import 'package:note_app_clone/domain/util/note_order.dart';
import 'package:note_app_clone/domain/util/order_type.dart';
import 'package:note_app_clone/presentation/notes/notes_event.dart';
import 'package:note_app_clone/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  NotesState _state = const NotesState(
    notes: [],
    noteOrder: NoteOrder.date(OrderType.descending()),
  );

  NotesState get state => _state;

  Note? _recentlyDeleteNote;

  NotesViewModel(this.useCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
      changeOrder: _changeOrder,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes.execute(state.noteOrder);
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNote.execute(note);

    _recentlyDeleteNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      await useCases.addNote.execute(_recentlyDeleteNote!);
      _recentlyDeleteNote = null;
    }
    _loadNotes();
  }

  void _changeOrder(NoteOrder noteOrder) {
    _state = state.copyWith(
      noteOrder: noteOrder,
    );
    _loadNotes();
  }
}
