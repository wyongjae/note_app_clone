import 'package:get_it/get_it.dart';
import 'package:note_app_clone/data/data_source/note_db_helper.dart';
import 'package:note_app_clone/data/repository/note_repository_impl.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';
import 'package:note_app_clone/domain/use_case/add_note_use_case.dart';
import 'package:note_app_clone/domain/use_case/delete_note_use_case.dart';
import 'package:note_app_clone/domain/use_case/get_note_use_case.dart';
import 'package:note_app_clone/domain/use_case/get_notes_use_case.dart';
import 'package:note_app_clone/domain/use_case/update_note_use_case.dart';
import 'package:note_app_clone/domain/use_case/use_cases.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> diSetup() async {
  Database database = await openDatabase(
    'note_db',
    version: 1,
    onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT,'
              ' title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
    },
  );

  getIt.registerLazySingleton<NoteDbHelper>(() => NoteDbHelper(database));

  getIt.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(getIt<NoteDbHelper>()));

  getIt.registerLazySingleton<UseCases>(() => UseCases(
        addNote: AddNoteUseCase(getIt<NoteRepository>()),
        deleteNote: DeleteNoteUseCase(getIt<NoteRepository>()),
        getNote: GetNoteUseCase(getIt<NoteRepository>()),
        getNotes: GetNotesUseCase(getIt<NoteRepository>()),
        updateNote: UpdateNoteUseCase(getIt<NoteRepository>()),
      ));
}
