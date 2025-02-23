class Entity {
  final int id;
  final String title;
  final double score;
  final String comment;
  final String category;
  final String status;
  final String creationDate;
  final String? pendingPriority;
  final String? postViewPriority;
  final String image;
  final String? position;

  Entity({
    this.id = 0,
    required this.title,
    required this.score,
    required this.comment,
    required this.category,
    required this.status,
    required this.creationDate,
    this.pendingPriority,
    this.postViewPriority,
    this.position,
    required this.image
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      score: json['score'] != null ? (json['score']!).toDouble() : double.parse('0.0'),
      comment: json['comment'] ?? '' ,
      category: json['category'] ?? '',
      status: json['status'] ?? '',
      creationDate: json['creation_date'] ?? '',
      pendingPriority: json['pending_priority'],
      postViewPriority: json['post_view_priority'],
      position: json['position'],
      image: json['imageUrl'] ?? ''
    );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'score': score,
    'comment': comment,
    'category_id': category,
    'status_id': status,
    'creationDate': creationDate,
    'pending_priority_id': pendingPriority,
    'post_view_priority_id': postViewPriority,
    'position': position,
    'image': image,
  };
}