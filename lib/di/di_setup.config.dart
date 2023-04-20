// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:note_app_clone/data/data_source/note_db_helper.dart' as _i4;
import 'package:note_app_clone/data/repository/note_repository_impl.dart'
    as _i6;
import 'package:note_app_clone/di/app_module.dart' as _i15;
import 'package:note_app_clone/domain/repository/note_repository.dart' as _i5;
import 'package:note_app_clone/domain/use_case/add_note_use_case.dart' as _i8;
import 'package:note_app_clone/domain/use_case/delete_note_use_case.dart'
    as _i9;
import 'package:note_app_clone/domain/use_case/get_note_use_case.dart' as _i10;
import 'package:note_app_clone/domain/use_case/get_notes_use_case.dart' as _i11;
import 'package:note_app_clone/domain/use_case/update_note_use_case.dart'
    as _i7;
import 'package:note_app_clone/domain/use_case/use_cases.dart' as _i12;
import 'package:note_app_clone/presentation/add_edit_note/add_edit_note_view_model.dart'
    as _i13;
import 'package:note_app_clone/presentation/notes/notes_view_model.dart'
    as _i14;
import 'package:sqflite/sqflite.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.Database>(
      () => appModule.database,
      preResolve: true,
    );
    gh.singleton<_i4.NoteDbHelper>(_i4.NoteDbHelper(gh<_i3.Database>()));
    gh.singleton<_i5.NoteRepository>(
        _i6.NoteRepositoryImpl(gh<_i4.NoteDbHelper>()));
    gh.singleton<_i7.UpdateNoteUseCase>(
        _i7.UpdateNoteUseCase(gh<_i5.NoteRepository>()));
    gh.singleton<_i8.AddNoteUseCase>(
        _i8.AddNoteUseCase(gh<_i5.NoteRepository>()));
    gh.singleton<_i9.DeleteNoteUseCase>(
        _i9.DeleteNoteUseCase(gh<_i5.NoteRepository>()));
    gh.singleton<_i10.GetNoteUseCase>(
        _i10.GetNoteUseCase(gh<_i5.NoteRepository>()));
    gh.singleton<_i11.GetNotesUseCase>(
        _i11.GetNotesUseCase(gh<_i5.NoteRepository>()));
    gh.singleton<_i12.UseCases>(_i12.UseCases(
      addNote: gh<_i8.AddNoteUseCase>(),
      deleteNote: gh<_i9.DeleteNoteUseCase>(),
      getNote: gh<_i10.GetNoteUseCase>(),
      getNotes: gh<_i11.GetNotesUseCase>(),
      updateNote: gh<_i7.UpdateNoteUseCase>(),
    ));
    gh.factory<_i13.AddEditNoteViewModel>(
        () => _i13.AddEditNoteViewModel(gh<_i12.UseCases>()));
    gh.factory<_i14.NotesViewModel>(
        () => _i14.NotesViewModel(gh<_i12.UseCases>()));
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
