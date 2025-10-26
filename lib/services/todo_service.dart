import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/todo.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;


class TodoService {
  final List<Todo> _todos = [];
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

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

  Future<void> initializeNotifications() async {
    tzdata.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await notificationPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(int id, String title, DateTime dateTime) async {
    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.from(dateTime, tz.local);
    
    await notificationPlugin.zonedSchedule(
      id,
      'Pengigat Tugas',
      title,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'todo_channel',
          'Todo Notifications',
          channelDescription: 'Notifications for todo reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  } 

  Future<void> cancelNotification(int id) async {
    await notificationPlugin.cancel(id);
  }
}