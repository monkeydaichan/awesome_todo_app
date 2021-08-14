import 'dart:async';

import 'package:awesome_todo_app/resource/entity/todo.dart';
import 'package:awesome_todo_app/resource/repository/hive_repository.dart';
import 'package:awesome_todo_app/resource/entity/todo_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final todoListProvider = StateNotifierProvider<TodoList, TodoState>((ref) {
  return TodoList(ref.read(todoRepositoryProvider));
});

class TodoList extends StateNotifier<TodoState> {
  TodoList(TodoRepository repository) : super(const TodoState()) {
    // ignore: prefer_initializing_formals
    todoRepository = repository;
    getTodos();
  }

  late TodoRepository todoRepository;
  Future<void> getTodos() async {
    Timer(const Duration(milliseconds: 1200), () async {
      final l = await todoRepository.fetchTodos();
      state = state.copyWith(articles: l, hasNext: false);

      return;
    });
  }

  Future<void> add(String title) async {
    final _todo = Todo(
      id: _uuid.v4(),
      title: title,
    );
    state = state.copyWith(articles: [
      ...state.articles,
      _todo,
    ]);
    return todoRepository.save(_todo);
  }

  void toggle(String id) {
    for (var todo in state.articles) {
      if (todo.id == id) {
        final _todo = Todo(
          id: todo.id,
          completed: !todo.completed,
          title: todo.title,
        );
        todoRepository.save(_todo);
      }
    }

    state = state.copyWith(articles: [
      for (final todo in state.articles)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            title: todo.title,
          )
        else
          todo,
    ]);
  }

  void edit({required String id, required String title}) {
    state = state.copyWith(articles: [
      for (final todo in state.articles)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            title: title,
          )
        else
          todo,
    ]);
  }

  Future<void> remove(Todo target) async {
    state = state.copyWith(
        articles:
            state.articles.where((todo) => todo.id != target.id).toList());
    return todoRepository.delete(target.id);
  }
}
