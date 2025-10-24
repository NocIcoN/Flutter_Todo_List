import 'package:flutter/material.dart';
import 'package:todo_list/services/todo_service.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  final TodoService _service = TodoService();

  @override
  void initState() {
    super.initState();
    _service.loadTodos().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _service.todos.length,
          itemBuilder: (context, index) {
            final todo = _service.todos[index];

            return Dismissible(
              key: Key(todo.title + index.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete),
              ),
              onDismissed: (_) {
                setState(() {
                  _service.removeTodoItem(index);
                });
              },
              child: Card(
                child: ListTile(
                  leading: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) {
                      setState(() {
                        _service.toggleTodo(index);
                      });
                    },
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: todo.isDone ? Colors.grey : Colors.black,
                    ),
                  ),
                  onTap: () => _showEditTaskDialog(index),
                  trailing: const Icon(Icons.edit),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    String newTask = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Tugas'),
          content: TextField(
            autofocus: true,
            onChanged: (value) => newTask = value,
            decoration: const InputDecoration(
              hintText: 'Masukkan nama tugas',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  setState(() {
                    _service.addTodo(newTask);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(int index) {
    String updatedTask = _service.todos[index].title;
    TextEditingController controller =
        TextEditingController(text: updatedTask);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Tugas'),
          content: TextField(
            controller: controller,
            autofocus: true,
            onChanged: (value) => updatedTask = value,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (updatedTask.isNotEmpty) {
                  setState(() {
                    _service.updateTodo(index, updatedTask);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}
