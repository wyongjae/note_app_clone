import 'package:note_app_clone/domain/use_case/add_note_use_case.dart';
import 'package:note_app_clone/domain/use_case/delete_note_use_case.dart';
import 'package:note_app_clone/domain/use_case/get_note_use_case.dart';
import 'package:note_app_clone/domain/use_case/get_notes_use_case.dart';
import 'package:note_app_clone/domain/use_case/update_note_use_case.dart';

class UseCases {
  final AddNoteUseCase addNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteUseCase getNoteUseCase;
  final GetNotesUseCase getNotesUseCase;
  final UpdateNoteUseCase updateNoteUseCase;

  UseCases({
    required this.addNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getNoteUseCase,
    required this.getNotesUseCase,
    required this.updateNoteUseCase,
  });
}
