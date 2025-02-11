class Saga {
  Saga({
    this.id = 0,
    required this.title,
    required this.numCaps,
    required this.season,
    required this.comment,
    required this.score,
    required this.categoryId,
    required this.statusId,
    required this.pendingPriorityId,
    required this.postViewPriorityId,
    required this.image,
  });

  final int id;
  final String title;
  final int numCaps;
  final int season;
  final String comment;
  final double score;
  final int categoryId;
  final int statusId;
  final int? pendingPriorityId;
  final int? postViewPriorityId;
  final String image;

  factory Saga.fromJson(Map<String, dynamic> json) => Saga(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    numCaps: json['num_caps'] ?? 0,
    season: json['season'] ?? 0,
    comment: json['final_comment'] ?? '',
    score: json['score'] != null ? json['score'].toDouble() : double.parse("0.0"),
    categoryId: json['category_id'] ?? 0,
    statusId: json['status_id'] ?? 0,
    pendingPriorityId: json['pending_priority_id'] ?? 0,
    postViewPriorityId: json['post_view_priority_id'] ?? 0,
    image: json['image'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'num_caps': numCaps,
    'season': season,
    'final_comment': comment,
    'category_id': categoryId,
    'status_id': statusId,
    'pending_priority_id': pendingPriorityId,
    'post_view_priority_id': postViewPriorityId,
    'image': image
  };
}