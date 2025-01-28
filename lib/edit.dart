import 'package:flutter/material.dart';

class EditTask extends StatelessWidget {
  const EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Task',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
        ),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Select Due Date'),
                  onPressed: () {}, // No functionality
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(Icons.access_time),
                  label: const Text('Select Time'),
                  onPressed: () {}, // No functionality
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: 'Low', // Default value
            items: [
              DropdownMenuItem(
                value: 'High',
                child: Text('High', style: TextStyle(color: const Color.fromARGB(255, 234, 81, 70))),
              ),
              DropdownMenuItem(
                value: 'Medium',
                child: Text('Medium', style: TextStyle(color: const Color.fromARGB(255, 237, 223, 98))),
              ),
              DropdownMenuItem(
                value: 'Low',
                child: Text('Low', style: TextStyle(color: const Color.fromARGB(255, 118, 241, 123))),
              ),
            ],
            onChanged: (value) {}, // No functionality
            decoration: const InputDecoration(labelText: 'Priority Level'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {}, // No functionality
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}