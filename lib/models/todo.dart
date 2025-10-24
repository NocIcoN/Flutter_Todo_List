class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'],
    isDone: json['isDone'],
  );
}

Map<String, dynamic> toJson(Todo todo) => {
  'title': todo.title,
  'isDone': todo.isDone,
};