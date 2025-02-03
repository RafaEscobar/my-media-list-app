class Media {

  final int id;
  final String title;
  final double score;
  final String comment;
  final int categoryId;
  final int statusId;
  final int pendingPriorityId;
  final int postViewPriorityId;
  final String image;

  Media({
    this.id = 0,
    this.title = '',
    this.score = 0.0,
    this.comment = '',
    this.categoryId = 0,
    this.statusId = 0,
    this.pendingPriorityId = 0,
    this.postViewPriorityId = 0,
    this.image = ''
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    score: json['score'] ?? 0.0,
    comment: json[''] ?? '',
    categoryId: json['category'] ?? 0,
    statusId: json['status'] ?? 0,
    pendingPriorityId: json['pending_priority_id'] ?? 0,
    postViewPriorityId: json['post_view_priority_id'] ?? 0,
    image: json['imageUrl'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "score": score,
    "comment": comment,
    "category_id": categoryId,
    "status_id": statusId,
    "pending_priority_id": pendingPriorityId,
    "post_view_priority_id": postViewPriorityId,
    "image": image
  };

}