class Priority {
  Priority({
    this.id = 0,
    this.priority = '',
    this.description = ''
  });

  int id;
  String priority;
  String description;

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
    id: json['id'] ?? 0,
    priority: json['priority'] ?? '',
    description: json['description'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'priority': priority,
    'description': description
  };
}