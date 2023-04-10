import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';

class UpdateNoteUseCase {
  final NoteRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<void> execute(Note note) async {
    await repository.updateNote(note);
  }
}
