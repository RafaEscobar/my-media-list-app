class Saga {
  Saga({
    this.id = 0,
    this.title = '',
    this.numCaps = 0,
    this.season = 0,
    this.comment = '',
    this.categoryId = 0,
    this.statusId = 0,
    this.pendingPriorityId = 0,
    this.postViewPriorityId = 0,
    this.image = '',
  });

  final int id;
  final String title;
  final int numCaps;
  final int season;
  final String comment;
  final int categoryId;
  final int statusId;
  final int pendingPriorityId;
  final int postViewPriorityId;
  final String image;

  factory Saga.fromJson(Map<String, dynamic> json) => Saga(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    numCaps: json['num_caps'] ?? 0,
    season: json['season'] ?? 0,
    comment: json['final_comment'] ?? '',
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