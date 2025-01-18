class Goal {
  String title;
  String category; // "Daily", "Short-term", or "Long-term"
  bool completed;
  DateTime createdAt;
  DateTime? completedDate; // New field for completion date

  Goal({
    required this.title,
    required this.category,
    this.completed = false,
    DateTime? createdAt,
    this.completedDate,
  }) : createdAt = createdAt ?? DateTime.now();
}
