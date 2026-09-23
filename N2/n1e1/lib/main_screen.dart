import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color background = Color(0xFF000000);

  static const Color primary = Color(0xFFDA70D6);
  static const Color secondary = Color(0xFF7A1F77);

  static const Color colorDone = Color(0xFFBFE59A);
  static const Color colorDoing = Color(0xFFAEBDEA);
  static const Color colorToDo = Color(0xFFEAEAAE);

  static const Color textColorToDo = Color(0xFF8E7D25);
  static const Color textColorDoing = Color(0xFF253F8E);
  static const Color textColorDone = Color(0xFF258E3F);
}

enum TaskState { toDo, doing, done }

extension TaskStateDecoration on TaskState {
  Color get backgroundColor {
    switch (this) {
      case TaskState.toDo:
        return AppColors.colorToDo;

      case TaskState.doing:
        return AppColors.colorDoing;

      case TaskState.done:
        return AppColors.colorDone;
    }
  }

  Color get textColor {
    switch (this) {
      case TaskState.toDo:
        return AppColors.textColorToDo;

      case TaskState.doing:
        return AppColors.textColorDoing;

      case TaskState.done:
        return AppColors.textColorDone;
    }
  }

  TextStyle get titleStyle {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: textColor,
    );
  }

  TextStyle get descriptionStyle {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textColor,
    );
  }
}

const sliverGridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 400,
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  mainAxisExtent: 310,
);

final List<Task> tasks = [
  Task(
    title: "Prova Cálculo",
    description: "Preciso estudar pra prova de cálculo N2",
    state: TaskState.toDo,
  ),
  Task(
    title: "Atividade Segunda",
    description: "Fazer o bgl do xavier do projeto A",
    state: TaskState.toDo,
  ),
  Task(
    title: "Conectar com o banco do cliente",
    description:
        "Realizar conexão via AnyDesk e conectar ao dataconnect da Goalfy",
    state: TaskState.doing,
  ),
  Task(
    title: "Notificações PinguIn",
    description:
        "Criar sistema de notificações e notificações push para o PinguIn",
    state: TaskState.done,
  ),
];

class Task {
  final String description;
  final String title;
  final TaskState state;

  const Task({
    required this.description,
    required this.title,
    required this.state,
  });
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Task> getTasksByState(TaskState state) {
    return tasks.where((task) => task.state == state).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: _TaskList(
                gridDelegate: sliverGridDelegate,
                tasks: getTasksByState(TaskState.toDo),
              ),
            ),
            Expanded(
              child: _TaskList(
                gridDelegate: sliverGridDelegate,
                tasks: getTasksByState(TaskState.doing),
              ),
            ),
            Expanded(
              child: _TaskList(
                gridDelegate: sliverGridDelegate,
                tasks: getTasksByState(TaskState.done),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.secondary),
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  final SliverGridDelegate gridDelegate;
  final List<Task> tasks;

  const _TaskList({required this.gridDelegate, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: tasks.length,
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return Card(
          color: task.state.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 30,
              right: 30,
            ),
            child: Column(
              spacing: 8,
              children: [
                Text(
                  task.title,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: task.state.titleStyle,
                ),
                Text(
                  task.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: task.state.descriptionStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
