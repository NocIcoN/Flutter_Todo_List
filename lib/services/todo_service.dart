import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    _todos.add(Todo(title: title));
    _saveTodos();
  }

  void toggleTodo(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    _saveTodos();
  }

  void removeTodoItem(int index) {
    _todos.removeAt(index);
    _saveTodos();
  }

  void updateTodo(int index, String updatedTitle) {
    _todos[index].title = updatedTitle;
    _saveTodos();
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _todos.map((todo) => toJson(todo)).toList();
    prefs.setString('todoList', json.encode(jsonList));
  }

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('todoList');
    if (data != null) {
      final decode = json.decode(data) as List<dynamic>;
      _todos.clear();
      _todos.addAll(decode.map((e) => Todo.fromJson(e)).toList());
    }  
  }
}