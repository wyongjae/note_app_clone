import 'package:go_router/go_router.dart';
import 'package:note_app_clone/di/di_setup.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';
import 'package:note_app_clone/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note_app_clone/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note_app_clone/presentation/notes/notes_screen.dart';
import 'package:note_app_clone/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => NotesViewModel(getIt<NoteRepository>()),
        child: const NotesScreen(),
      ),
    ),
    GoRoute(
      path: '/addEditScreen',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => AddEditNoteViewModel(getIt<NoteRepository>()),
        child: const AddEditNoteScreen(),
      ),
    ),
  ],
);
