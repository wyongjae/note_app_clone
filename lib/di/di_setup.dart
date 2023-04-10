import 'package:get_it/get_it.dart';
import 'package:note_app_clone/data/data_source/note_db_helper.dart';
import 'package:note_app_clone/data/repository/note_repository_impl.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';
import 'package:note_app_clone/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note_app_clone/presentation/notes/notes_view_model.dart';
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

  getIt.registerLazySingleton<NotesViewModel>(
      () => NotesViewModel(getIt<NoteRepository>()));

  getIt.registerLazySingleton<AddEditNoteViewModel>(
      () => AddEditNoteViewModel(getIt<NoteRepository>()));
}
