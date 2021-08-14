import 'dart:math';

import 'package:awesome_todo_app/resource/entity/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
}

final todoRepositoryProvider = Provider((ref) => TodoRepositoryImpl(ref.read));

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._reader);

  final Reader _reader;

  // late final NewsDataSource _dataSource = _reader(newsDataSourceProvider);

  @override
  Future<List<Todo>> fetchTodos() {
    final r = <Todo>[];
    return Future.value(r);
  }
}
