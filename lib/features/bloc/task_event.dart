part of 'task_bloc.dart';

@immutable
sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final String title;
  final String description;
  final String tag;

  const AddTask(
      {required this.title, required this.description, required this.tag});

  @override
  List<Object> get props => [title, description, tag];
}

class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask({required this.id});

  @override
  List<Object> get props => [id];
}

class EditTask extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final String tag;

  const EditTask({
    required this.title,
    required this.description,
    required this.tag,
    required this.id
  });

  @override
  List<Object> get props => [title, description, tag];
}
// class TaskRequest extends TaskEvent {
//   const TaskRequest();
// }

// class AddTask extends TaskEvent {
//   final TodoModel todo;
//   final bool isCompleted;

//   const AddTask({required this.todo, required this.isCompleted});

//   @override
//   List<Object> get props => [todo, isCompleted];
// }

// class DeleteTask extends TaskEvent {
//   final TodoModel todo;

//   const DeleteTask(this.todo);

//   @override
//   List<Object> get props => [todo];
// }

// class UpdateTask extends TaskEvent {}

// class CompletedTask extends TaskEvent {
//   const CompletedTask();
// }
