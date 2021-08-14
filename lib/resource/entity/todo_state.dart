import 'package:awesome_todo_app/resource/entity/todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';
part 'todo_state.g.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default(<Todo>[]) List<Todo> articles,
    @Default(true) bool hasNext,
    @Default('') String keyword,
  }) = _TodoState;

  factory TodoState.fromJson(Map<String, dynamic> json) =>
      _$TodoStateFromJson(json);
}
