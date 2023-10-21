import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/features/utils/colors.dart';
import 'package:newapp/features/utils/helper_widget.dart';
import 'package:newapp/features/utils/widget/custome_card.dart';
import '../bloc/task_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TaskBloc>(context);

    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "To-Do List",
          style: TextStyle(color: ColorsTheme.white),
        ),
        centerTitle: true,
        backgroundColor: ColorsTheme.brown,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.calendar_month,
              color: ColorsTheme.white,
            ),
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is SuccessState) {
            return ListView.builder(
                itemCount: state.todo.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    context: context,
                    taskBloc: todoBloc,
                    description: state.todo[0].description,
                    title: state.todo[0].title,
                    tag: state.todo[0].tag,
                    onTap:
                        () {}, // still to be implemented to increase functionality
                  );
                });
          } else {
            return const Center(child: Text('No Todos Yet'));
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorsTheme.white,
        shape: const CircularNotchedRectangle(),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            icon: const Icon(
              Icons.list_alt,
              color: Colors.black,
            ),
            onPressed:
                () {}, // still to be implemented to increase functionality
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.task,
                color: Colors.black,
              ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TodoPopup todoPopup = TodoPopup(taskBloc: todoBloc);
          todoPopup.openDialog(false, context);
        },
        backgroundColor: ColorsTheme.brown,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: ColorsTheme.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
}
