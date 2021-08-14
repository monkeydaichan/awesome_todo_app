import 'package:awesome_todo_app/resource/entity/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList([
    Todo(id: 'todo-0', title: 'hi'),
    Todo(id: 'todo-1', title: 'hello'),
    Todo(id: 'todo-2', title: 'bonjour'),
  ]);
});

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String title) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        title: title,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            title: todo.title,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String title}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            title: title,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
