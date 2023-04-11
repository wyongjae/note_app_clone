import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:note_app_clone/domain/model/note.dart';
import 'package:note_app_clone/domain/repository/note_repository.dart';
import 'package:note_app_clone/domain/use_case/get_notes_use_case.dart';
import 'package:note_app_clone/domain/util/note_order.dart';
import 'package:note_app_clone/domain/util/order_type.dart';

import 'get_note_use_case.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  test('정렬 기능이 잘 동작해야 한다', () async {
    final repository = MockNoteRepository();

    final getNotes = GetNotesUseCase(repository);

    // 동작 정의
    when(repository.getNotes()).thenAnswer((_) async => const [
          Note(title: 'title', content: 'content', color: 1, timestamp: 1),
          Note(title: 'title2', content: 'content2', color: 2, timestamp: 2),
        ]);

    List<Note> result =
        await getNotes.execute(const NoteOrder.date(OrderType.descending()));

    // MockNoteRepository 의 getNotes 가 실행이 된 건지 확인하는 코드
    verify(repository.getNotes());

    // 타입 검사
    expect(result, isA<List<Note>>);

    // descending (내림차순) 정렬이기 때문에 큰 값이 위로
    expect(result.first.timestamp, 2);

    result =
        await getNotes.execute(const NoteOrder.date(OrderType.ascending()));

    // ascending (오름차순) 정렬이기 때문에 큰 값이 위로
    expect(result.first.timestamp, 1);
  });
}
