import 'package:awesome_todo_app/resource/entity/todo.dart';
import 'package:awesome_todo_app/view/todo_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider((_) => TodoListFilter.all);
final uncompletedTodosCount = Provider<int>((ref) {
  return ref
      .watch(todoListProvider)
      .articles
      .where((todo) => !todo.completed)
      .length;
});
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter.state) {
    case TodoListFilter.completed:
      return todos.articles.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.articles.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos.articles;
  }
});
