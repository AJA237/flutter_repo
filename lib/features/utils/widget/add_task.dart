import 'package:flutter/material.dart';

class CustomTask extends StatelessWidget {
  const CustomTask({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
        child: const Column(
      children: [
        Row(
          children: [Icon(Icons.menu), TextField(autocorrect: true)],
        ),
        Row(
          children: [
            Icon(Icons.messenger_outlined),
            TextField(autocorrect: true)
          ],
        ),
        Row(
          children: [Icon(Icons.task), TextField(autocorrect: true)],
        )
      ],
    ));
  }
}
