// Task model
class Task {
  final int id;
  final String title;
  final String description;
  final int rewardPoints;
  final bool active;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.rewardPoints,
    required this.active,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        rewardPoints: json['reward_points'] ?? 0,
        active: json['active'] ?? true,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
      );
}
