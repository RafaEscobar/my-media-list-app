import 'package:mymedialist/models/entity.dart';

class Saga extends Entity{
  Saga({
    super.id,
    required super.title,
    required super.score,
    required super.comment,
    required super.category,
    required super.type,
    required super.status,
    required super.creationDate,
    required super.pendingPriority,
    required super.postViewPriority,
    required super.images,
    required this.numCaps,
    required this.season,
  });

  final int numCaps;
  final int season;

  factory Saga.fromJson(Map<String, dynamic> json) {
    try {
      return Saga(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        score: json['score'] != null ? json['score'].toDouble() : double.parse('0.0'),
        comment: json['final_comment'] ?? '' ,
        category: json['classification']?['category'] ?? '',
        type: json['classification']?['type'] ?? '',
        status: json['status'] ?? '',
        creationDate: json['creation_date'] != null ? DateTime.parse(json['creation_date']!) : DateTime.now(),
        pendingPriority: json['pending_priority'] ?? '',
        postViewPriority: json['post_view_priority'] ?? '',
        images: json['imageUrl'] ?? [],
        numCaps: json['num_caps'] != null ? json['num_caps']! : 0,
        season: json['season'] != null ? json['season']! : 0
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'score': score,
    'final_comment': comment,
    'category': category,
    'type': type,
    'status': status,
    'creationDate': creationDate,
    'pending_priority': pendingPriority,
    'post_view_priority': postViewPriority,
    'images': images,
    'num_caps': numCaps,
    'season': season
  };

}