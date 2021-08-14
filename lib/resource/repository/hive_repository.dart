import 'package:awesome_todo_app/resource/entity/todo.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<void> save(Todo todo);
  Future<void> delete(String id);
}

final todoRepositoryProvider =
    Provider((ref) => TodoRepositoryImpl(ref.read, TodoModelBox()));

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._reader, TodoModelBox todoModelBox) {
    _todoModelBox = todoModelBox;
  }
  late TodoModelBox _todoModelBox;
  final Reader _reader;

  @override
  Future<List<Todo>> fetchTodos() async {
    final box = await _todoModelBox.box;
    return box.values.toList();
  }

  @override
  Future<void> save(Todo todo) async {
    final box = await _todoModelBox.box;
    return box.put(todo.id, todo);
  }

  @override
  Future<void> delete(String id) async {
    final Box box = await _todoModelBox.box;
    return box.delete(id);
  }
}
