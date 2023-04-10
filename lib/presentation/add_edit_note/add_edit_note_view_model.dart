import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/use_case/use_cases.dart';
import 'package:note_app_clone/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:note_app_clone/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:note_app_clone/ui/colors.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final UseCases useCases;

  int _color = roseBud.value;

  int get color => _color;

  final _eventStreamController = StreamController<AddEditNoteUiEvent>();

  Stream<AddEditNoteUiEvent> get eventStream => _eventStreamController.stream;

  AddEditNoteViewModel(this.useCases);

  void onEvent(AddEditNoteEvent event) {
    event.when(
      changeColor: _changeColor,
      saveNote: _saveNote,
    );
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if (id == null) {
      await useCases.addNoteUseCase.execute(
        Note(
          title: title,
          content: content,
          color: color,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } else {
      await useCases.updateNoteUseCase.execute(
        Note(
          id: id,
          title: title,
          content: content,
          color: color,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    }

    _eventStreamController.add(const AddEditNoteUiEvent.saveNote());
  }
}
