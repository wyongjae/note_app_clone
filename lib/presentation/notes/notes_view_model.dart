import 'package:flutter/material.dart';
import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/use_case/use_cases.dart';
import 'package:note_app_clone/presentation/notes/notes_event.dart';
import 'package:note_app_clone/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  NotesState _state = const NotesState(
    notes: [],
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
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotesUseCase.execute();
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNoteUseCase.execute(note);

    _recentlyDeleteNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      await useCases.addNoteUseCase.execute(_recentlyDeleteNote!);
      _recentlyDeleteNote = null;
    }
    _loadNotes();
  }
}
