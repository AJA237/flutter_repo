import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final String description;
  final String date = DateTime.now().toIso8601String();
  final String tag;

  TodoModel({
    required this.title,
    this.isCompleted = false,
    this.description = '',
    required this.tag,
    String? id,
  })  : assert(
            id == null || id.isNotEmpty, "id must either be null or not empty"),
        id = id ?? const Uuid().v4();
  TodoModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? description,
    String? date,
    String? tag,
  }) {
    return TodoModel(
      title: title ?? this.title,
      tag: tag ?? this.tag,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }

  static TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      id: json['id'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'id': id,
      'tag': tag,
    };
  }

  @override
  List<Object> get props => [id, title, description, isCompleted, tag];
}
