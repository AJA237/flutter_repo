import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:newapp/features/bloc/task_bloc.dart';
import 'package:newapp/features/utils/colors.dart';

class TodoPopup {
  final TaskBloc taskBloc;

  TodoPopup({required this.taskBloc});

  Future openDialog(
    bool update,
    BuildContext context,
  ) async {
    final result = await showDialog(
        context: context,
        builder: ((context) {
          return AlertBox(
            taskBloc: taskBloc,
          );
        }));
    await result;
  }
}

class AlertBox extends StatelessWidget {
  final TaskBloc taskBloc;

  AlertBox({super.key, required this.taskBloc});
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "New Task",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 250.0,
        width: 250,
        child: Column(
          children: [
            TaskTextField(
              hintText: "Task",
              icons: const Icon(Icons.checklist),
              controller: _taskController,
            ),
            TaskTextField(
              hintText: "Description",
              icons: const Icon(Icons.chat_bubble),
              controller: _descriptionController,
            ),
            ListTile(
              leading: const Icon(Icons.tag),
              title: DropdownButtonFormField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(10),
                value: "Work",
                hint: const Text("Add a Task Tag"),
                items: const [
                  DropdownMenuItem(
                    value: "Work",
                    child: Text("Work"),
                  ),
                  DropdownMenuItem(
                    value: "School",
                    child: Text("School"),
                  ),
                  DropdownMenuItem(value: "Others", child: Text("Others")),
                ],
                onChanged: ((value) {
                  _tagController.text = value.toString();
                }),
              ),
            )
          ],
        ),
      ),
      actions: [
        TaskButtonsEdit(
          title: "Cancel",
          color: ColorsTheme.grey!,
          onPressed: () {
            Navigator.pop(context);
            // implement onPressed function with bloc to cancel an AlertDialog and return to the previous screen
          },
        ),
        TaskButtonsEdit(
          title: "Save",
          color: ColorsTheme.brown!,
          onPressed: () {
            taskBloc.add(AddTask(
              title: _taskController.text,
              description: _descriptionController.text,
              tag: _tagController.text,
            ));
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Task has been add"),
            ));
          },
        ),
      ],
    );
  }
}

class TaskButtonsEdit extends StatelessWidget {
  final String title;
  final Color color;
  final Function()? onPressed;

  const TaskButtonsEdit(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: color),
        child: Text(title, style: const TextStyle(color: ColorsTheme.white)));
  }
}

class TaskTextField extends StatelessWidget {
  final String? hintText;
  final Icon icons;
  final TextEditingController controller;

  TaskTextField({
    super.key,
    required this.hintText,
    required this.icons,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: hintText,
        ),
      ),
      leading: icons,
    );
  }
}
