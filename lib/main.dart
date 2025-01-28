import 'package:flutter/material.dart';
import 'package:first_ui/add.dart';
import 'package:first_ui/edit.dart';

void main() => runApp(ToDoApp());

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoScreen(),
    );
  }
}

class ToDoScreen extends StatelessWidget {
  // Use a ValueNotifier to manage the state of tasks
  final ValueNotifier<List<Map<String, String>>> tasksNotifier = ValueNotifier([
    {'priority': 'Low'},
    {'priority': 'Medium'},
    {'priority': 'High'},
    {'priority': 'Low'},
    {'priority': 'Medium'},
  ]);

  void _updateTaskPriority(int index, String newPriority) {
    // Update the task list through the ValueNotifier
    tasksNotifier.value = [
      for (int i = 0; i < tasksNotifier.value.length; i++)
        if (i == index) {'priority': newPriority} else tasksNotifier.value[i]
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do App',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<List<Map<String, String>>>(
          valueListenable: tasksNotifier,
          builder: (context, tasks, _) {
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItem(
                  priority: task['priority']!,
                  onPriorityChanged: (newPriority) {
                    _updateTaskPriority(index, newPriority);
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String priority;
  final ValueChanged<String> onPriorityChanged;

  const TaskItem({
    super.key,
    required this.priority,
    required this.onPriorityChanged,
  });

  Color _getContainerColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color.fromARGB(255, 166, 26, 26);
      case 'Medium':
        return const Color.fromARGB(255, 191, 174, 17);
      case 'Low':
        return const Color.fromARGB(255, 21, 110, 19);
      default:
        return Colors.grey[200]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _getContainerColor(priority),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {}, // No functionality
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text('Due: 15/01/2025 at 10:00 AM'),
                Row(
                  children: [
                    Container(
                      // color: const Color.fromRGBO(222, 216, 216, 1),
                      child: DropdownButton<String>(
                        value: priority,
                        items: const [
                          DropdownMenuItem(
                            value: 'High',
                            child: Text('High',
                                style: TextStyle(color: Colors.red)),
                          ),
                          DropdownMenuItem(
                            value: 'Medium',
                            child: Text('Medium',
                                style: TextStyle(color: Colors.yellow)),
                          ),
                          DropdownMenuItem(
                            value: 'Low',
                            child: Text('Low',
                                style: TextStyle(color: Colors.green)),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            onPriorityChanged(value); 
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTask(),
                ),
              );
            }, // No functionality
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {}, // No functionality
          ),
        ],
      ),
    );
  }
}