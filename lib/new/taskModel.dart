class Task {
  int? id;
  String title;
  String note;
  String date;
  String time;
  bool completed;


  Task({this.id, required this.title, required this.note, required this.date, required this.time,    this.completed = false,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    note: json['note'],
    date: json['date'],
    time: json['time'],
    completed: json['completed'] == 1,
  );
//sed to convert  Task object into a Map<String, dynamic>,
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'note': note,
    'date': date,
    'time': time,
    'completed': completed ? 1 : 0,
  };
}
