import 'package:go_router/go_router.dart';
import 'package:note_app_clone/di/di_setup.dart';
import 'package:note_app_clone/domain/model/note.dart';
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
        create: (_) => getIt<NotesViewModel>(),
        child: const NotesScreen(),
      ),
    ),
    GoRoute(
      path: '/addEditScreen',
      builder: (context, GoRouterState state) {
        Note? note = state.extra as Note?;

        return ChangeNotifierProvider(
          create: (_) => getIt<AddEditNoteViewModel>(),
          child: AddEditNoteScreen(
            note: note,
          ),
        );
      },
    ),
  ],
);
