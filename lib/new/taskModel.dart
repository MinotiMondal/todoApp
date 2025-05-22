class Task {
  int? id;
  String title;
  String note;
  String date;
  String time;

  Task({this.id, required this.title, required this.note, required this.date, required this.time});

  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    note: json['note'],
    date: json['date'],
    time: json['time'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'note': note,
    'date': date,
    'time': time,
  };
}
