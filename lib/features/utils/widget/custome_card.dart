import 'package:flutter/material.dart';
import 'package:newapp/features/utils/colors.dart';
import 'package:newapp/features/utils/helper_widget.dart';

import '../../bloc/task_bloc.dart';

class CustomCard extends StatelessWidget {
  final TaskBloc taskBloc;
  final String title;
  final String description;
  final String tag;
  Function()? onTap;
  bool status = true;

  CustomCard({
    super.key,
    required BuildContext context,
    required this.taskBloc,
    required this.tag,
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
                TodoPopup(taskBloc: taskBloc);
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
