import 'package:flutter/material.dart';
import 'package:newapp/features/utils/colors.dart';
import 'package:newapp/features/utils/helper_widget.dart';

import '../../bloc/task_bloc.dart';

class CustomCard extends StatelessWidget {
  final TaskBloc taskBloc;
  final String title;
  final String description;
  Function()? onTap;
  bool status = true;

  CustomCard({
    super.key,
    required BuildContext context,
    required this.taskBloc,
    required this.description,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: Navigator.pop(context),
      child: Card(
          child: ListTile(
        leading: Icon(
          Icons.circle,
          color: status ? ColorsTheme.green : ColorsTheme.red,
        ),
        trailing: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          icon: const Icon(Icons.more_vert),
          items: [
            DropdownMenuItem(
              value: 'edit',
              onTap: () {
                TodoPopupEdit(
                  taskBloc: taskBloc,
                  id: taskBloc.todos[0].id,
                  tag: taskBloc.todos[0].tag,
                  description: taskBloc.todos[0].description,
                  title: taskBloc.todos[0].title,
                );
              },
              child: const Text('Edit'),
            ),
            DropdownMenuItem(
              value: 'delete',
              onTap: () {
                taskBloc.add(DeleteTask(id: taskBloc.todos[0].id));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Task has been deleted"),
                ));
              },
              child: const Text('Delete'),
            ),
          ],
          onChanged: (value) {},
        )),
        title: Text(title),
        subtitle: Text(description),
      )),
    );
  }
}

class TodoPopupEdit extends StatefulWidget {
  final TaskBloc taskBloc;
  final String id;
  final String title;
  final String description;
  final String tag;

  TodoPopupEdit({
    required this.taskBloc,
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
  });

  @override
  _TodoPopupEditState createState() => _TodoPopupEditState();
}

class _TodoPopupEditState extends State<TodoPopupEdit> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _tag;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _description = widget.description;
    _tag = widget.tag;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              initialValue: _description,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
            TextFormField(
              initialValue: _tag,
              decoration: InputDecoration(labelText: 'Tag'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a tag';
                }
                return null;
              },
              onSaved: (value) {
                _tag = value!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.taskBloc.add(EditTask(
                id: widget.id,
                title: _title,
                description: _description,
                tag: _tag,
              ));
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
