import 'package:mymedialist/models/entity.dart';

class Saga extends Entity{
  Saga({
    super.id,
    required super.title,
    required super.score,
    required super.comment,
    required super.categoryId,
    required super.statusId,
    required super.pendingPriorityId,
    required super.postViewPriorityId,
    required super.image,
    required this.numCaps,
    required this.season,
  });

  final int numCaps;
  final int season;

  factory Saga.fromJson(Map<String, dynamic> json) => Saga(
    id: json['id'] ?? 0,
    title: json['title'] ?? '',
    score: json['score'] != null ? json['score'].toDouble() : double.parse('0.0'),
    comment: json['final_comment'] ?? '' ,
    categoryId: json['category_id'] ?? 0 ,
    statusId: json['status_id'] ?? 0,
    pendingPriorityId: json['pending_priority_id'] ?? 0,
    postViewPriorityId: json['post_view_priority_id'] ?? 0,
    image: json['imageUrl'] ?? '',
    numCaps: json['num_caps'] ?? 0,
    season: json['season'] ?? 0
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'score': score,
    'final_comment': comment,
    'category_id': categoryId,
    'status_id': statusId,
    'pending_priority_id': pendingPriorityId,
    'post_view_priority_id': postViewPriorityId,
    'imageUrl': image,
    'num_caps': numCaps,
    'season': season
  };

}