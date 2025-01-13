class Media {

  final int id;
  final String title;
  final double score;
  final String comment;
  final String category;
  final String status;
  final String priority;
  final String imagePath;

  Media({
    this.id = 0,
    this.title = '',
    this.score = 0.0,
    this.comment = '',
    this.category = '',
    this.status = '',
    this.priority = '',
    this.imagePath = ''
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    score: json['score'] ?? 0.0,
    comment: json[''] ?? '',
    category: json['category'] ?? '',
    status: json['status'] ?? '',
    priority: json['priority'] ?? '',
    imagePath: json['imageUrl'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "score": score,
    "comment": comment,
    "category": category,
    "status": status,
    "priority": priority,
    "imagePath": imagePath
  };

}