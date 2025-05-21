class Task {
  final int? id;
  final String title;
  final String date;
  final String time;
  final String note;

  Task({this.id, required this.title, required this.date, required this.time, required this.note});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time,
      'note': note,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      time: map['time'],
      note: map['note'],
    );
  }
}
