part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class InitialState extends TaskState {}

final class LoadingState extends TaskState {}

final class SuccessState extends TaskState {
  final List<TodoModel> todo;

  const SuccessState({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

final class FailureState extends TaskState {
  final Object _error;

  const FailureState(this._error);

  @override
  List<Object> get props => [_error];
}



// enum TaskState { initial, loading, success, failure }

// @immutable
// final class TaskState extends Equatable {
//   final TaskStatus status;
//   final List<TodoModel> todos;
//   final TodoModel? lastDeletedTask;
//   const TaskState({
//     this.status = TaskStatus.initial,
//     this.todos = const [],
//     this.lastDeletedTask,
//   });
//   TaskState copyWith({
//     TaskStatus Function()? status,
//     List<TodoModel> Function()? todos,
//     TodoModel? Function()? lastDeletedTask,
//   }) {
//     return TaskState(
//       status: status != null ? status() : this.status,
//       todos: todos != null ? todos() : this.todos,
//       lastDeletedTask: lastDeletedTask != null ? lastDeletedTask() : this.lastDeletedTask,
//     );
//   }

//   @override
//   List<Object?> get props => [status, todos];
// }
