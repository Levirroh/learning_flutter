import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color background = Color(0xFF161616);
  static const Color surface = Color(0xFF222222);
  static const Color surfaceLight = Color(0xFF2C2C2C);

  static const Color primary = Color(0xFFDA70D6);
  static const Color secondary = Color(0xFF7A1F77);

  static const Color textPrimary = Color(0xFFF2F2F2);
  static const Color textSecondary = Color(0xFFAFAFAF);

  static const Color divider = Color(0xFF3A3A3A);

  static const Color colorDone = Color(0xFFBFE59A);
  static const Color colorDoing = Color(0xFFAEBDEA);
  static const Color colorToDo = Color(0xFFEAEAAE);

  static const Color textColorToDo = Color(0xFF8E7D25);
  static const Color textColorDoing = Color(0xFF253F8E);
  static const Color textColorDone = Color(0xFF258E3F);
}

enum TaskState {
  toDo,
  doing,
  done,
}

enum TaskFilter {
  all,
  toDo,
  doing,
  done,
}

extension TaskStateDecoration on TaskState {
  Color get color {
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

  String get label {
    switch (this) {
      case TaskState.toDo:
        return "A fazer";

      case TaskState.doing:
        return "Fazendo";

      case TaskState.done:
        return "Concluída";
    }
  }
}

extension TaskFilterDecoration on TaskFilter {
  String get label {
    switch (this) {
      case TaskFilter.all:
        return "Todas";

      case TaskFilter.toDo:
        return "A fazer";

      case TaskFilter.doing:
        return "Fazendo";

      case TaskFilter.done:
        return "Concluídas";
    }
  }
}

class Task {
  final String title;
  final String description;
  final TaskState state;

  const Task({
    required this.title,
    required this.description,
    required this.state,
  });

  Task copyWith({
    String? title,
    String? description,
    TaskState? state,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      state: state ?? this.state,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TaskFilter selectedFilter = TaskFilter.all;

  List<Task> tasks = [
    const Task(
      title: "Prova Cálculo",
      description: "Preciso estudar pra prova de cálculo N2",
      state: TaskState.toDo,
    ),
    const Task(
      title: "Atividade Segunda",
      description: "Fazer o bgl do xavier do projeto A",
      state: TaskState.toDo,
    ),
    const Task(
      title: "Conectar com o banco do cliente",
      description:
          "Realizar conexão via AnyDesk e conectar ao dataconnect da Goalfy",
      state: TaskState.doing,
    ),
    const Task(
      title: "Notificações PinguIn",
      description:
          "Criar sistema de notificações e notificações push para o PinguIn",
      state: TaskState.done,
    ),
  ];

  List<Task> get filteredTasks {
    switch (selectedFilter) {
      case TaskFilter.all:
        return tasks;

      case TaskFilter.toDo:
        return tasks
            .where((task) => task.state == TaskState.toDo)
            .toList();

      case TaskFilter.doing:
        return tasks
            .where((task) => task.state == TaskState.doing)
            .toList();

      case TaskFilter.done:
        return tasks
            .where((task) => task.state == TaskState.done)
            .toList();
    }
  }

  int get pendingTasks {
    return tasks.where((task) => task.state != TaskState.done).length;
  }

  void toggleTask(Task task) {
    final index = tasks.indexOf(task);

    if (index == -1) return;

    setState(() {
      final newState =
          task.state == TaskState.done ? TaskState.toDo : TaskState.done;

      tasks[index] = task.copyWith(
        state: newState,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              pendingTasks: pendingTasks,
            ),
            _Filters(
              selectedFilter: selectedFilter,
              onFilterSelected: (filter) {
                setState(() {
                  selectedFilter = filter;
                });
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filteredTasks.isEmpty
                  ? const _EmptyTasks()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        12,
                        16,
                        100,
                      ),
                      itemCount: filteredTasks.length,
                      separatorBuilder: (_, _) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];

                        return _TaskItem(
                          task: task,
                          onToggle: () {
                            toggleTask(task);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int pendingTasks;

  const _Header({
    required this.pendingTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        22,
        20,
        16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Minhas tarefas",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "$pendingTasks tarefas pendentes",
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  final TaskFilter selectedFilter;
  final ValueChanged<TaskFilter> onFilterSelected;

  const _Filters({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: TaskFilter.values.length,
        separatorBuilder: (_, _) {
          return const SizedBox(width: 8);
        },
        itemBuilder: (context, index) {
          final filter = TaskFilter.values[index];
          final selected = filter == selectedFilter;

          return InkWell(
            onTap: () {
              onFilterSelected(filter);
            },
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.divider,
                ),
              ),
              child: Text(
                filter.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? AppColors.background
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const _TaskItem({
    required this.task,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = task.state == TaskState.done;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.divider,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onToggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(top: 2),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDone
                        ? AppColors.primary
                        : Colors.transparent,
                    border: Border.all(
                      width: 2,
                      color: isDone
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                  ),
                  child: isDone
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.background,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDone
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      task.description,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textSecondary,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: task.state.color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        task.state.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: task.state.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  const _EmptyTasks();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 56,
            color: AppColors.primary,
          ),
          SizedBox(height: 16),
          Text(
            "Nenhuma tarefa",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Nada para mostrar nesse filtro.",
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}