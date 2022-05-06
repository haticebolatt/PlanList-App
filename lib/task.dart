class Task {
  final String title;
  bool isDone;

  Task({
    required this.title,
    this.isDone = false,
  });

  void Toggle() {
    isDone = !isDone;
  }

  Task.fromMap(Map<dynamic, dynamic> map)
      : title = map['title'],
        isDone = map['isDone']; //String, dyamic

  Map<String, dynamic> toMap() => {'title': title, 'isDone': isDone};
}
