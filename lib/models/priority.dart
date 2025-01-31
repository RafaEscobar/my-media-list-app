class Priority {
  Priority({
    this.id = 0,
    this.priority = ''
  });

  int id;
  String priority;

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
    id: json['id'] ?? 0,
    priority: json['priority'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'priority': priority
  };
}