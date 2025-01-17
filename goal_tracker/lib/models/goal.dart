class Goal {
  String title;
  String category; // "Daily", "Short-term", or "Long-term"
  bool completed;
  DateTime createdAt;

  Goal({
    required this.title,
    required this.category,
    this.completed = false, // Default to false (not completed)
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
