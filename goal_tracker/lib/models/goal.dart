class Goal {
  String title;
  String category; // "Daily", "Short-term", or "Long-term"
  DateTime createdAt;

  Goal({
    required this.title,
    required this.category,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now(); // Defaults to now if not provided
}
