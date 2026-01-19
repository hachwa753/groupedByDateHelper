class Todo {
  final String id;
  final String title;
  final bool isDone;
  final DateTime dateTime;

  Todo({
    required this.id,
    required this.title,
    required this.dateTime,
    this.isDone = false,
  });

  Todo copyWith({String? id, String? title, DateTime? dateTime, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      isDone: map['isDone'],
    );
  }
}
