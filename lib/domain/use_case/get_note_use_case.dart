import 'package:injectable/injectable.dart';
import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';

@singleton
class GetNoteUseCase {
  final NoteRepository repository;

  GetNoteUseCase(this.repository);

  Future<Note?> execute(int id) async {
    return await repository.getNoteById(id);
  }
}