class Entity {
  final int id;
  final String title;
  final double score;
  final String comment;
  final int categoryId;
  final int statusId;
  final int? pendingPriorityId;
  final int? postViewPriorityId;
  final String image;

  Entity({
    this.id = 0,
    required this.title,
    required this.score,
    required this.comment,
    required this.categoryId,
    required this.statusId,
    this.pendingPriorityId,
    this.postViewPriorityId,
    required this.image
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    score: json['score'].toDouble() ?? double.parse('0.0'),
    comment: json['comment'] ?? '' ,
    categoryId: json['category_id'] ?? 0,
    statusId: json['status_id'] ?? 0,
    pendingPriorityId: json['pending_priority_id'],
    postViewPriorityId: json['post_view_priority_id'],
    image: json['imageUrl'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'score': score,
    'comment': comment,
    'category_id': categoryId,
    'status_id': statusId,
    'pending_priority_id': pendingPriorityId,
    'post_view_priority_id': postViewPriorityId,
    'image': image,
  };
}