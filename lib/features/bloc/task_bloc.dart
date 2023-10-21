import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:newapp/features/model/model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  List<TodoModel> todos = [];
  TaskBloc() : super(InitialState()) {
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<EditTask>(_onEditTask);
  }
  void _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    print("Help");
    try {
      emit(LoadingState());
      final newTodo = TodoModel(
        title: event.title,
        tag: event.tag,
        description: event.description,
      );
      todos.add(newTodo);
      emit(SuccessState(todo: List.from(todos)));
    } catch (e) {
      emit(FailureState(e));
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      emit(LoadingState());
      todos.removeWhere((todo) => todo.id == event.id);
      emit(SuccessState(todo: List.from(todos)));
    } catch (e) {
      emit(FailureState(e));
    }
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) async {
    try {
      final todoIndex = todos.indexWhere((todo) => todo.id == event.id);
      if (todoIndex != -1) {
        todos[todoIndex] = TodoModel(
            title: event.title, tag: event.tag, description: event.description);
      }
    } catch (e) {
      emit(FailureState(e));
    }
  }
}
