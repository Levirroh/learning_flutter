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
  static const Color done = Color(0xFFBFE59A);
}

class Task {
  final String title;
  final bool completed;

  const Task({
    required this.title,
    this.completed = false,
  });

  Task copyWith({
    String? title,
    bool? completed,
  }) {
    return Task(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController taskController = TextEditingController();

  final List<Task> tasks = [
    Task(title: "Fazer atividade de dispositivos móveis"),
    Task(title: "Fazer atividade 2 de dispositivos móveis"),
    Task(title: "Estudar para N2 de cálculo!!!"),
  ];

  List<Task> get orderedTasks {
    final ordered = [...tasks];

    ordered.sort((a, b) {
      if (a.completed == b.completed) {
        return 0;
      }

      return a.completed ? 1 : -1;
    });

    return ordered;
  }

  int get pendingTasks {
    return tasks.where((task) => !task.completed).length;
  }

  void addTask() {
    final title = taskController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Digite uma tarefa antes de adicionar.",
          ),
        ),
      );

      return;
    }

    setState(() {
      tasks.add(
        Task(
          title: title,
        ),
      );
    });

    taskController.clear();

    FocusScope.of(context).unfocus();
  }

  void toggleTask(Task task, bool? value) {
    final index = tasks.indexOf(task);

    if (index == -1) {
      return;
    }

    setState(() {
      tasks[index] = task.copyWith(
        completed: value ?? false,
      );
    });
  }

  Future<void> editTask(Task task) async {
    final editedTask = await showDialog<Task>(
      context: context,
      builder: (context) {
        return TaskDialog(
          task: task,
        );
      },
    );

    if (editedTask == null) {
      return;
    }

    final index = tasks.indexOf(task);

    if (index == -1) {
      return;
    }

    setState(() {
      tasks[index] = editedTask;
    });
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleTasks = orderedTasks;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: const Text(
          "Minhas Tarefas",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: taskController,
                cursorColor: AppColors.primary,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  labelText: "Nova tarefa",
                  hintText: "Ex: Estudar Flutter",
                  labelStyle: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  prefixIcon: const Icon(
                    Icons.task_alt,
                    color: AppColors.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.divider,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.divider,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                onSubmitted: (_) {
                  addTask();
                },
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: addTask,
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: const Text(
                    "Adicionar",
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Tarefas",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "$pendingTasks pendentes",
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: visibleTasks.isEmpty
                    ? const _EmptyTasks()
                    : ListView.builder(
                        itemCount: visibleTasks.length,
                        itemBuilder: (context, index) {
                          final task = visibleTasks[index];

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: _TaskTile(
                              task: task,
                              onChanged: (value) {
                                toggleTask(task, value);
                              },
                              onEdit: () {
                                editTask(task);
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onEdit;

  const _TaskTile({
    required this.task,
    required this.onChanged,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.divider,
        ),
      ),
      child: CheckboxListTile(
        value: task.completed,

        onChanged: onChanged,

        activeColor: AppColors.primary,
        checkColor: AppColors.background,

        controlAffinity: ListTileControlAffinity.leading,

        contentPadding: const EdgeInsets.only(
          left: 8,
          right: 4,
          top: 2,
          bottom: 2,
        ),

        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: task.completed
                ? AppColors.textSecondary
                : AppColors.textPrimary,
            decoration: task.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: AppColors.textSecondary,
          ),
        ),

        secondary: IconButton(
          onPressed: onEdit,
          icon: const Icon(
            Icons.edit_outlined,
            color: AppColors.primary,
            size: 20,
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
            size: 60,
            color: AppColors.primary,
          ),
          SizedBox(height: 14),
          Text(
            "Nenhuma tarefa cadastrada",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Adicione uma tarefa acima.",
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class TaskDialog extends StatefulWidget {
  final Task task;

  const TaskDialog({
    super.key,
    required this.task,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.task.title,
    );
  }

  void save() {
    final title = controller.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "O texto da tarefa não pode ficar vazio.",
          ),
        ),
      );

      return;
    }

    Navigator.pop(
      context,
      widget.task.copyWith(
        title: title,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Editar tarefa",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: controller,
              cursorColor: AppColors.primary,
              autofocus: true,
              style: const TextStyle(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                labelText: "Tarefa",
                labelStyle: const TextStyle(
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: AppColors.surfaceLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                FilledButton(
                  onPressed: save,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background,
                  ),
                  child: const Text(
                    "Salvar",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}