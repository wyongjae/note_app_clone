import 'package:go_router/go_router.dart';
import 'package:note_app_clone/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note_app_clone/presentation/notes/notes_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NotesScreen(),
    ),
    GoRoute(
      path: '/addEditScreen',
      builder: (context, state) => const AddEditNoteScreen(),
    ),
  ],
);