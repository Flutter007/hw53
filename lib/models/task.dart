class Task {
  final String task;
  final String categoryId;
  final DateTime createdAt;

  Task({required this.task, required this.categoryId, required this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'categoryId': categoryId,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      task: json['task'],
      categoryId: json['categoryId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
