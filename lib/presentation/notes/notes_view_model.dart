import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';
import 'package:note_app_clone/presentation/notes/notes_event.dart';

class NotesViewModel with ChangeNotifier {
  final NoteRepository repository;

  List<Note> _notes = [];

  Note? _recentlyDeleteNote;

  List<Note> get notes => UnmodifiableListView(_notes);

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
    _notes = notes;
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
