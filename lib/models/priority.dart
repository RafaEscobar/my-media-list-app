class Priority {
  final int id;
  final String priority;

  Priority({
    this.id = 0,
    this.priority = ''
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
    id: json['id'] ?? 0,
    priority: json['priority'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "priority": priority
  };
}