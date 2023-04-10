import 'package:flutter/material.dart';
import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';
import 'package:note_app_clone/presentation/notes/notes_event.dart';
import 'package:note_app_clone/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final NoteRepository repository;

  NotesState _state = const NotesState(
    notes: [],
  );

  NotesState get state => _state;

  Note? _recentlyDeleteNote;

  NotesViewModel(this.repository);

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await repository.getNotes();
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await repository.deleteNote(note);

    _recentlyDeleteNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      await repository.insertNote(_recentlyDeleteNote!);
      _recentlyDeleteNote = null;
    }
    _loadNotes();
  }
}
