class Chapter {
  final int id;
  final String name;
  final String comment;
  final int sagaId;
  final double score;

  Chapter({
    required this.id,
    required this.name,
    required this.comment,
    required this.sagaId,
    required this.score
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    comment: json['comment'] ?? '',
    sagaId: json['saga_id'] ?? 0,
    score: (json['score']).toDouble()
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "comment": comment,
    "saga_id": sagaId,
    "score": score
  };
}