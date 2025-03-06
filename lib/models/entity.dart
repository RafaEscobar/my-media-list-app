class Entity {
  final int id;
  final String title;
  final double score;
  final String comment;
  final String category;
  final String status;
  final DateTime creationDate;
  final String? pendingPriority;
  final String? postViewPriority;
  final String image;
  final String? position;
  final String? type;

  Entity({
    this.id = 0,
    required this.title,
    required this.score,
    required this.comment,
    required this.category,
    required this.status,
    required this.creationDate,
    required this.type,
    this.pendingPriority,
    this.postViewPriority,
    this.position,
    required this.image
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    try {
      return Entity(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        score: json['score'] != null ? (json['score']!).toDouble() : double.parse('0.0'),
        comment: json['comment'] ?? '' ,
        category: json['classification']?['category'] ?? '',
        type: json['classification']?['type'] ?? '',
        status: json['status'] ?? '',
        creationDate: json['creation_date'] != null ? DateTime.parse(json['creation_date']!) : DateTime.now(),
        pendingPriority: json['pending_priority'],
        postViewPriority: json['post_view_priority'],
        position: json['position'],
        image: json['imageUrl'] ?? ''
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'score': score,
    'comment': comment,
    'category_id': category,
    'type': type,
    'status_id': status,
    'creationDate': creationDate,
    'pending_priority_id': pendingPriority,
    'post_view_priority_id': postViewPriority,
    'position': position,
    'image': image,
  };
}